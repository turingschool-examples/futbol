require_relative 'game'
require_relative 'seasons_manager'
require_relative 'parsable'

class GamesManager < SeasonsManager
  include Parsable
  attr_reader :games

  def initialize(file_path)
    @games = make_objects(file_path, Game)
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
    results(min_max, all_team_scores(hoa))
  end

  def all_team_scores(hoa)
    {
      max: -> { hoa_goals(hoa).call.max_by { |_team, data| hash_avg(data) }.first },
      min: -> { hoa_goals(hoa).call.min_by { |_team, data| hash_avg(data) }.first }
    }
  end

  def hoa_goals(hoa)
    goals = {
      home: -> { get_hoa_goals(hoa) },
      away: -> { get_hoa_goals(hoa) }
    }
    goals[hoa]
  end

  def opponent_results(id, min_max)
    results(min_max, opponent_min_max(id))
  end

  def opponent_min_max(id)
    data = opponent_win_count(id)
    {
      min: -> { win_percent(data).min_by { |_team, result| result }.first },
      max: -> { win_percent(data).max_by { |_team, result| result }.first }
    }
  end

  def game_score_results(min_max)
    game = {
      max: -> { @games.max_by { |game| game.total_goals } },
      min: -> { @games.min_by { |game| game.total_goals } }
    }
    game[min_max].call.total_goals
  end

  def results(min_max, block)
    block[min_max].call
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
