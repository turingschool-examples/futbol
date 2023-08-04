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

  def average_goals_per_game
    total_games = 0
    total_goals = 0

    @game_data.each do |row|
      total_goals += row[:home_goals].to_i + row[:away_goals].to_i
      total_games += 1
    end
    average_goals = total_goals.to_f / total_games
    average_goals.round(2)
  end

  def best_offense
    total_games = 0
    total_goals = 0
  end
end