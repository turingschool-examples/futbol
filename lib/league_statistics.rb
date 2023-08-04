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


  # def best_offense
  #   games = read_csv(@file)

  #   offense = Hash.new { |hash, key| hash[key] = [] }
    
  #   games.each do |row|
  #     team = row["team_id"].to_i
  #     goals = row["goals"].to_i
  #     offense[team] << goals
  #   end

  #   best_offense_team_id = nil
  #   highest_average_goals = -1

  #   offense.each do |team_id, goals|
  #     average_goals = goals.sum.to_f / goals.size
  #     if average_goals > highest_average_goals
  #       highest_average_goals = average_goals
  #       best_offense_team_id = team_id
  #     end
  #   end

  #   best_offense_team = nil
  #   teams = read_csv("./data/teams.csv")

  #   teams.each do |row|
  #     if row["team_id"].to_i == best_offense_team_id
  #       best_offense_team = row["teamName"]
  #     end
  #   end

  #   best_offense_team
  # end
end