require 'csv'
require_relative 'game'
require_relative 'seasons_manager'

class GamesManager < SeasonsManager
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
    get_season_game_count
  end

  def average_goals_by_season
    avg_season_goals(goals_per_season)
  end

  def goals_per_season
    get_goals_per_season
  end

  def average_goals_per_game
    goal_per_game_avg(@games)
  end

  def games_per_season(season)
    get_games_per_season(season)
  end

  def get_hoa_goals(hoa)
    @games.each_with_object({}) do |game, acc|
      team_id, goals = get_game_info(game)[hoa]
      acc[team_id] ||= { goals: 0, total: 0 }
      acc[team_id][:goals] += goals
      acc[team_id][:total] += 1
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
      max: -> { info[hoa].call.max_by { |_team, data| hash_avg(data) }.first },
      min: -> { info[hoa].call.min_by { |_team, data| hash_avg(data) }.first }
    }
    team[min_max].call
  end

  def opponent_results(id, fav_rival)
    data = opponent_win_count(id)
    team = {
      fav: -> { win_percent(data).min_by { |_team, result| result }.first },
      rival: -> { win_percent(data).max_by { |_team, result| result }.first }
    }
    team[fav_rival].call
  end

  def opponent_win_count(id)
    @games.each_with_object({}) do |game, acc|
      next unless game.has_team?(id)

      opponent_game(acc, id, game)
    end
  end

  def opponent_game(acc, id, game)
    opp_id = opponent_id(id, game)
    acc[opp_id] ||= { wins: 0, total: 0 }
    acc[opp_id][:wins] += 1 unless game.winner?(id)
    acc[opp_id][:total] += 1
  end

  def opponent_id(id, game)
    if game.home_team?(id)
      game.away_team_id
    else
      game.home_team_id
    end
  end
end
