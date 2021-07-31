require 'csv'
require './lib/game_teams'

class GameTeamsManager
  attr_reader :game_teams

  def initialize(file_path)
    @game_teams = []
    make_game_teams(file_path)
  end

#helper
  def make_game_teams(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      @game_teams << GameTeams.new(row)
    end
  end

# Interface
  def winningest_coach(season)
    most_wins = coach_win_pct(season).max_by do|coach, pct|
      pct
    end
    most_wins[0]
  end

# Interface
  def worst_coach(season)
    least_wins = coach_win_pct(season).min_by do|coach, pct|
      pct
    end
    least_wins[0]
  end

#helper
  def coach_win_pct(season)
    test = coach_wins(season).each.reduce({}) do |acc, (coach, results)|
      acc[coach] = results[:wins].fdiv(results[:total])
      acc
    end
  end

#helper
  def coach_wins(season)
    @game_teams.reduce({}) do |acc, game|
      if game.game_id[0..3] == season[0..3]
        acc[game.coach] ||= {wins: 0, total: 0}
        if game.result == "WIN"
          acc[game.coach][:wins] += 1
        end
        acc[game.coach][:total] += 1
      end
      acc
    end
  end

#helper
  def get_accuracy_data(season)
    accuracy_data = Hash.new
    @game_teams.each do |game|
      if game.game_id[0..3] == season[0..3]
        accuracy_data[game.team_id] ||= {goals: 0, shots: 0}
        accuracy_data[game.team_id][:goals] += game.goals
        accuracy_data[game.team_id][:shots] += game.shots
      end
    end
    accuracy_data
  end

#helper
  def get_accuracy_average(season)
    accuracy_data = get_accuracy_data(season)
    accuracy_average = Hash.new
    accuracy_data.each do |team, data|
      accuracy_average[team] = data[:goals].fdiv(data[:shots])
    end
    accuracy_average
  end

# Interface
  def most_accurate_team(season)
    accuracy_average = get_accuracy_average(season)
    accuracy_average.max_by do |team, average|
      average
    end.first
  end

# Interface
  def least_accurate_team(season)
    accuracy_average = get_accuracy_average(season)
    accuracy_average.min_by do |team, average|
      average
    end.first
  end

#helper
  def team_tackles(season)
    @game_teams.reduce({}) do |acc, game|
      if game.game_id[0..3] == season[0..3]
        acc[game.team_id] ||= 0
        acc[game.team_id] += game.tackles
      end
      acc
    end
  end

# Interface
  def most_tackles(season)
    team_tackles(season).max_by do |team, tackles|
      tackles
    end.first
  end

# Interface
  def fewest_tackles(season)
    team_tackles(season).min_by do |team, tackles|
      tackles
    end.first
  end

#Helper
  def get_away_team_goals
    away_avg = {}
    @game_teams.each do |game|

      away_avg[game.team_id] ||= { goals: 0, total: 0 }
      if game.home_away == "away"
        away_avg[game.team_id][:goals] += game.goals
        away_avg[game.team_id][:total] += 1
      end
    end
    away_avg
  end

#Interface
  def highest_scoring_visitor
    away_info = get_away_team_goals
    team_id = away_info.each.max_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_id
  end

#Interface
  def lowest_scoring_visitor
    away_info = get_away_team_goals
    team_id = away_info.each.min_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_id
  end

#Interface
  def best_season(team_id)
    get_season_averages(team_id).max_by do |season, average|
      average
    end.first
  end

#Interface
  def worst_season(team_id)
    get_season_averages(team_id).min_by do |season, average|
      average
    end.first
  end

#Helper
  def get_season_averages(team_id)
    season_average = seasons_win_count(team_id)
    season_average.map do |season, stats|
      [season, stats[:wins].fdiv(stats[:total])]
    end
  end

#Helper
  def seasons_win_count(team_id)
    @game_teams.reduce({}) do |acc, game|
      if game.team_id == team_id
        acc[game.season] ||= {wins: 0, total: 0}
        process_game(acc[game.season], game)
      end
      acc
    end
  end

#Helper
  def process_game(data, game)
    data[:wins] += 1 if game.won?
    data[:total] += 1
  end

  #Interface
  def most_goals_scored(team_id)
    goals_per_team_game(team_id).max
  end

  #Helper
  def goals_per_team_game(team_id)
    @game_teams.map do |game|
      game.goals if game.team_id == team_id
    end.compact
  end

  #Interface
  def fewest_goals_scored(team_id)
    goals_per_team_game(team_id).min
  end

  # Interface
  def best_offense
    team_id = get_offense_averages.max_by do |team, data|
      data
    end.first

    team_info(team_id)["team_name"]
  end

  # Interface
  def worst_offense
    team_id = get_offense_averages.min_by do |team, data|
      data
    end.first

    team_info(team_id)["team_name"]
  end

  # Helper
  def get_offense_averages
     get_goals_per_team.map do |team, data|
      [team, data[:goals].fdiv(data[:total])]
    end.to_h
  end
end
