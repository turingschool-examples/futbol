require 'csv'
require_relative 'game'
require_relative 'team'

class StatTracker 
  #include modules

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  attr_reader :game_data, :team_data, :game_teams_data

  def initialize(locations)
    @game_data = CSV.read locations[:games], headers: true, header_converters: :symbol
    @team_data = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams_data = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end

  def all_games
    games = []
    @game_data.each do |row|
      game_details = {
        id: row[:game_id].to_i,
        season: row[:season],
        season_type: row[:type],
        date: row[:date_time],
        away_id: row[:away_team_id].to_i,
        home_id: row[:home_team_id].to_i,
        away_goals: row[:away_goals].to_i,
        home_goals: row[:home_goals].to_i
      }
      games << Game.new(game_details)
    end
    games
  end

  def all_teams
    teams = []
    @team_data.each do |row|
      team_details = {
        team_id: row[:team_id].to_i,
        franchise_id: row[:franchiseid],
        team_name: row[:teamname],
        abbreviation: row[:abbreviation],
        stadium: row[:stadium]
      }
      team = Team.new(team_details)
      team.games = all_games.select { |game| game.home_id == team.team_id || game.away_id == team.team_id }
      teams << team
    end
    teams
  end
end
