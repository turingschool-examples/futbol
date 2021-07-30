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
end
