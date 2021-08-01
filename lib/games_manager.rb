require 'csv'
require_relative 'game'
require_relative 'percentageable'

class GamesManager
  include Percentageable
  attr_reader :games

  def initialize(file_path)
    @games = []
    make_games(file_path)
  end

  def make_games(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      @games << Game.new(row)
    end
  end

  def score_results(min_max)
    min_max_game = {
      max: -> { @games.max_by { |game| game.total_goals } },
      min: -> { @games.min_by { |game| game.total_goals } }
    }
    game = min_max_game[min_max].call
    game.total_goals
  end

  def count_of_games_by_season
    @games.reduce({}) do |acc, game|
      acc[game.season] ||= 0
      acc[game.season] += 1
      acc
    end
  end

  def average_goals_by_season
    goals_per_season.reduce({}) do |acc, goals|
      acc[goals[0]] = avg(goals[1], games_per_season(goals[0])).round(2)
      acc
    end
  end

  def goals_per_season
    @games.reduce({}) do |acc, game|
      acc[game.season] ||= 0
      acc[game.season] += game.total_goals
      acc
    end
  end

  def average_goals_per_game
    goals = @games.sum do |game|
      game.total_goals
    end
    (avg(goals, @games.size)).round(2)
  end

  def games_per_season(season)
    @games.count do |game|
      game.season == season
    end
  end

  def get_hoa_goals(hoa)
    @games.reduce({}) do |acc, game|
      team_id, goals = get_game_info(game)[hoa]
      acc[team_id] ||= { goals: 0, total: 0 }
      acc[team_id][:goals] += goals
      acc[team_id][:total] += 1
      acc
    end
  end

  def get_game_info(game)
    {
      home: [game.home_team_id, game.home_goals],
      away: [game.away_team_id, game.away_goals]
    }
  end

  def team_scores(hoa, min_max)
    info = {
      home: -> { get_hoa_goals(hoa) },
      away: -> { get_hoa_goals(hoa) }
    }
    team = {
      max: -> { info[hoa].call.max_by { |team, data| hash_avg(data) }.first },
      min: ->{ info[hoa].call.min_by { |team, data| hash_avg(data) }.first }
    }
    team[min_max].call
  end

  def opponent_id(id, game)
    if game.home_team?(id)
      game.away_team_id
    else
      game.home_team_id
    end
  end

  def opponent_results(id)
    data = opponent_win_count(id)
    {
      fav: -> { win_percent(data).min_by { |team, result| result }.first },
      rival: -> { win_percent(data).max_by { |team, result| result }.first }
    }
  end

  def opponent_win_count(id)
    @games.reduce({}) do |acc, game|
      if game.has_team?(id)
        opp_id = opponent_id(id, game)
        acc[opp_id] ||= {wins: 0, total: 0}
        acc[opp_id][:wins] += 1 if !game.winner?(id)
        acc[opp_id][:total] += 1
      end
      acc
    end
  end
end
