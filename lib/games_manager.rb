require 'csv'
require_relative 'game'
require_relative 'mathable'

class GamesManager
  include Mathable
  attr_reader :games

  def initialize(file_path)
    @games = []
    make_games(file_path)
  end

# helper
  def make_games(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      @games << Game.new(row)
    end
  end

#Interface
  def score_results(min_max)
    min_max_game = {
      max: -> { @games.max_by { |game| game.total_goals } },
      min: -> { @games.min_by { |game| game.total_goals } }
    }
    game = min_max_game[min_max].call
    game.total_goals
  end

  #Interface
  def count_of_games_by_season
    @games.reduce({}) do |acc, game|
      acc[game.season] ||= 0
      acc[game.season] += 1
      acc
    end
  end

##Interface
  def average_goals_by_season
    goals_per_season.reduce({}) do |acc, season_goals|
      acc[season_goals[0]] = season_goals[1].fdiv(games_per_season(season_goals[0])).round(2)
      acc
    end
  end

  ##helper
  def goals_per_season
    @games.reduce({}) do |acc, game|
      acc[game.season] ||= 0
      acc[game.season] += goals_per_game(game)
      acc
    end
  end

  ##helper
  def goals_per_game(game)
    game.away_goals + game.home_goals
  end

##Interface
  def average_goals_per_game
    goals = @games.sum do |game|
      game.away_goals + game.home_goals
    end
    (goals.fdiv(@games.size)).round(2)
  end

  ##Interface
  def games_per_season(season)
    @games.count do |game|
      game.season == season
    end
  end

  #Helper
  def get_home_team_goals
    @games.reduce({}) do |acc, game|
      acc[game.home_team_id] ||= { goals: 0, total: 0 }
      acc[game.home_team_id][:goals] += game.home_goals
      acc[game.home_team_id][:total] += 1
      acc
    end
  end

# Interface
  def team_scores(hoa, min_max)
    info = {
      home: -> { get_home_team_goals },
      away: -> { get_visitor_goals }
    }
    team = {
      max: -> { info[hoa].call.max_by { |team, data| average(data) }.first },
      min: -> { info[hoa].call.min_by { |team, data| average(data) }.first }
    }
    team[min_max].call
  end

  #Helper
  ##same as get_awway_team_goals in GameTeamsMgr
  def get_visitor_goals
    @games.reduce({}) do |acc, game|
      acc[game.away_team_id] ||= { goals: 0, total: 0 }
      acc[game.away_team_id][:goals] += game.away_goals
      acc[game.away_team_id][:total] += 1
      acc
    end
  end

  # We send team_id, they return hash with opp_id & results against
  # Helper
  def opponent_win_count(team_id)
    @games.reduce({}) do |acc, game|
      if game.has_team?(team_id)
        opp_id = opponent_id(team_id, game)
        acc[opp_id] ||= {wins: 0, total: 0}
        acc[opp_id][:wins] += 1 if !game.winner?(team_id)
        acc[opp_id][:total] += 1
      end
      acc
    end
  end

  def opponent_id(team_id, game)
    if game.home_team?(team_id)
      game.away_team_id
    else
      game.home_team_id
    end
  end

  ########
  # Interface
  def opponent_results(team_id)
    {
      fav: -> { win_percent(team_id).min_by { |team, result| result }.first },
      rival: -> { win_percent(team_id).max_by { |team, result| result }.first }
    }
  end

  # Helper
  def win_percent(team_id)
    win_loss = opponent_win_count(team_id)
    win_loss.map do |team, results|
      [team, average(results)]
    end
  end
end
