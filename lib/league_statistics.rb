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

  def average_goals_by_team
    total_goals_by_team = Hash.new(0)
    total_games_by_team = Hash.new(0)

    
  end
end