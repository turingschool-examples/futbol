require 'csv'
require_relative 'game'

class StatTracker < Game
  attr_reader :game_team_data, :game_data, :team_data
  
  def initialize(game_data, team_data, game_team_data)
    @game_team_data = game_team_data_creation(game_team_data)
    @game_data = game_data_creation(game_data)
    @team_data = team_data_creation(team_data)
  end

  def self.from_csv(locations)
    game_team_data = CSV.open(locations[:game_teams], headers: true, header_converters: :symbol)
    game_data = CSV.open(locations[:games], headers: true, header_converters: :symbol)
    team_data = CSV.open(locations[:teams], headers: true, header_converters: :symbol)
    
    new(game_data, team_data, game_team_data)
  end

  def team_data_creation(data)
    team_data = []
    
    data.each do |row| 
      teams_hash = {}
      teams_hash[:team_id] = row[:team_id]
      teams_hash[:team_name] = row[:teamname]
      teams_hash[:stadium] = row[:stadium]
      
      team_data << teams_hash
    end
    team_data
  end

  def game_team_data_creation(data)
    game_team_data = []

    data.each do |row|
      game_teams_hash = {}
      game_teams_hash[:game_id] = row[:game_id]
      game_teams_hash[:team_id] = row[:team_id]
      game_teams_hash[:hoa] = row[:hoa]
      game_teams_hash[:result] = row[:result]
      game_teams_hash[:head_coach] = row[:head_coach]
      game_teams_hash[:goals] = row[:goals]
      game_teams_hash[:shots] = row[:shots]
      game_teams_hash[:tackles] = row[:tackles]
      game_teams_hash[:game_id] = row[:game_id]

      game_team_data << game_teams_hash
    end
    game_team_data
  end

  def game_data_creation(data)
    game_data = []

    data.each do |row|
      game_data_hash = {}
      game_data_hash[:game_id] = row[:game_id]
      game_data_hash[:season] = row[:season]
      game_data_hash[:away_team_id] = row[:away_team_id]
      game_data_hash[:home_team_id] = row[:home_team_id]
      game_data_hash[:away_goals] = row[:away_goals]
      game_data_hash[:home_goals] = row[:home_goals]

      game_data << game_data_hash
    end
    game_data
  end
end

