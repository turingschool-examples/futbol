require 'csv'
require_relative 'game_teams'
require_relative 'seasons_manager'
# require_relative 'percentageable'

class GameTeamsManager < SeasonsManager
  # include Percentageable
  attr_reader :game_teams

  def initialize(file_path)
    @game_teams = []
    make_game_teams(file_path)
  end

  def make_game_teams(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      @game_teams << GameTeams.new(row)
    end
  end

  def coach_results(season)
    {
      max: -> {
        coach_win_pct(season, @game_teams).max_by { |coach, pct| pct }.first
      },
      min: -> {
        coach_win_pct(season, @game_teams).min_by { |coach, pct| pct }.first
      }
    }
  end

  def accuracy_results(season)
    average = get_accuracy_avg(accuracy_data(season))
    {
      max: -> { average.max_by { |team, avg| avg }.first },
      min: -> { average.min_by { |team, avg| avg }.first }
    }
  end

  def accuracy_data(season)
    @game_teams.reduce({}) do |acc, game|
      if game.game_id[0..3] == season[0..3]
        acc[game.team_id] ||= {goals: 0, shots: 0}
        acc[game.team_id][:goals] += game.goals
        acc[game.team_id][:shots] += game.shots
      end
      acc
    end
  end

  def tackle_results(season)
    {
      max: -> { team_tackles(season).max_by { |team, tackles| tackles }.first },
      min: -> { team_tackles(season).min_by { |team, tackles| tackles }.first }
    }
  end

  def team_tackles(season)
    @game_teams.reduce({}) do |acc, game|
      if game.game_id[0..3] == season[0..3]
        acc[game.team_id] ||= 0
        acc[game.team_id] += game.tackles
      end
      acc
    end
  end

  def season_results(team_id)
    averages = season_avgs(seasons_win_count(team_id))
    {
      max: -> { averages.max_by { |season, avg| avg }.first },
      min: -> { averages.min_by { |season, avg| avg }.first }
    }
  end

  def seasons_win_count(team_id)
    @game_teams.reduce({}) do |acc, game|
      if game.team_id == team_id
        acc[game.season] ||= {wins: 0, total: 0}
        process_game(acc[game.season], game)
      end
      acc
    end
  end

  def average_win_percentage(team_id)
    team_stats = team_win_stats(team_id)
    hash_avg(team_stats).round(2)
  end

  def team_win_stats(team_id)
    @game_teams.reduce({wins: 0, total: 0}) do |acc, game|
      process_game(acc, game) if game.team_id == team_id
      acc
    end
  end

  def process_game(data, game)
    data[:wins] += 1 if game.won?
    data[:total] += 1
  end

  def goal_results(team_id)
    {
      min: -> { goals_per_team_game(team_id).min },
      max: -> { goals_per_team_game(team_id).max }
    }
  end

  def goals_per_team_game(team_id)
    @game_teams.map do |game|
      game.goals if game.team_id == team_id
    end.compact
  end

  def offense_results
    shot_data = get_offense_avgs(get_goals_per_team)
    {
      min: -> { shot_data.min_by { |team, data| data }.first },
      max: -> { shot_data.max_by { |team, data| data }.first }
    }
  end

  def get_goals_per_team
    @game_teams.reduce({}) do |acc, game|
      acc[game.team_id] ||= {goals: 0, total: 0}
      acc[game.team_id][:goals] += game.goals
      acc[game.team_id][:total] += 1
      acc
    end
  end

  def percentage_hoa_wins(hoa)
    team = {home: "home", away: "away"}
    get_percentage_hoa_wins(team[hoa], @game_teams)
  end

  def percentage_ties
    get_percentage_ties(@game_teams)
  end
end
