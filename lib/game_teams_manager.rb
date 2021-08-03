require_relative 'game_teams'
require_relative 'seasons_manager'
require_relative 'parsable'

class GameTeamsManager < SeasonsManager
  include Parsable
  attr_reader :game_teams

  def initialize(file_path)
    @game_teams = make_objects(file_path, GameTeams)
  end

  def coach_results(season, min_max)
    results(min_max, calc_min_or_max(coach_win_pct(season)))
  end

  def accuracy_results(season, min_max)
    results(min_max, calc_min_or_max(accuracy_avg(accuracy_data(season))))
  end

  def season_results(id, min_max)
    results(min_max, calc_min_or_max(season_avgs(seasons_win_count(id))))
  end

  def tackle_results(season, min_max)
    results(min_max, calc_min_or_max(team_tackles(season)))
  end

  def calc_min_or_max(data)
    {
      max: -> { data.max_by { |_team, stats| stats }.first },
      min: -> { data.min_by { |_team, stats| stats }.first }
    }
  end

  def average_win_percentage(id)
    team_stats = team_win_stats(id)
    hash_avg(team_stats).round(2)
  end

   def results(min_max, block)
    block[min_max].call
   end

  def team_win_stats(id)
    @game_teams.each_with_object({ wins: 0, total: 0 }) do |game, acc|
      process_game(acc, game) if game.team_id == id
    end
  end

  def process_game(data, game)
    data[:wins] += 1 if game.won?
    data[:total] += 1
  end

  def goal_results(id, min_max)
    results(min_max, goal_min_max(id))
  end

  def goal_min_max(id)
    {
      min: -> { goals_per_team_game(id).min },
      max: -> { goals_per_team_game(id).max }
    }
  end

  def goals_per_team_game(id)
    @game_teams.map do |game|
      game.goals if game.team_id == id
    end.compact
  end

  def offense_results(min_max)
    shot_data = get_offense_avgs(get_goals_per_team)
    results = {
      min: -> { shot_data.min_by { |_team, data| data }.first },
      max: -> { shot_data.max_by { |_team, data| data }.first }
    }
    results[min_max].call
  end

  def get_goals_per_team
    @game_teams.each_with_object({}) do |game, acc|
      acc[game.team_id] ||= { goals: 0, total: 0 }
      acc[game.team_id][:goals] += game.goals
      acc[game.team_id][:total] += 1
    end
  end

  def percentage_hoa_wins(hoa)
    team = { home: 'home', away: 'away' }
    get_percentage_hoa_wins(team[hoa], @game_teams)
  end

  def percentage_ties
    get_percentage_ties(@game_teams)
  end
end
