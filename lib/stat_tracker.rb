require 'csv'
require_relative 'league'
require_relative 'game'
require_relative 'season'

class StatTracker
    attr_reader :game_data, :team_data, :game_teams_data, :game, :league, :season
  
    def initialize(locations)
      @game_data = CSV.read(locations[:games], headers: true)
      @team_data = CSV.read(locations[:teams], headers: true)
      @game_teams_data = CSV.read(locations[:game_teams], headers: true)
  
      game_row = @game_data.first
      game_id = game_row['game_id']
      season = game_row['season']
      type = game_row['type']
      date_time = game_row['date_time']
      away_team_id = game_row['away_team_id']
      home_team_id = game_row['home_team_id']
      away_goals = game_row['away_goals']
      home_goals = game_row['home_goals']
      venue = game_row['venue']
      venue_link = game_row['venue_link']
  
      @game = Game.new(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals, venue, venue_link)
    end
  end
  