require 'csv'

class LeagueStatistics
  attr_reader :locations,
              :teams_data,
              :game_data,
              :game_team_data

  def initialize(locations)
    @locations = locations
    @game_data = CSV.open locations[:games], headers: true, header_converters: :symbol
    @teams_data = CSV.open locations[:teams], headers: true, header_converters: :symbol
    @game_team_data = CSV.open locations[:game_teams], headers: true, header_converters: :symbol  
  end

  def count_of_teams
    team_ids = teams_data.map { |row| row[:team_id].to_i }

    team_ids.size
  end

  def team_name_by_id(team_id)
    team_id = team_id.to_i
    team = @teams_data.find { |row| row[:team_id].to_i == team_id }
    team[:teamname] if team
  end

  def best_offense
    goals_per_team = Hash.new { |hash, key| hash[key] = { total_goals: 0, games_played: 0 } }

    @game_team_data.each do |row|
      team_id = row[:team_id].to_i
      goals = row[:goals].to_i
      goals_per_team[team_id][:total_goals] += goals
      goals_per_team[team_id][:games_played] += 1
    end

    highest_average_team_id = nil
    highest_average = 0.0

    goals_per_team.each do |team_id, data|
      average_goals = data[:total_goals].to_f / data[:games_played]
      if average_goals > highest_average
        highest_average = average_goals
        highest_average_team_id = team_id
      end
    end

    team_name_by_id(highest_average_team_id)
  end
end