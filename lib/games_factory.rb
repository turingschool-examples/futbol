#./lib/games_factory.rb
require 'csv'

class GamesFactory
  attr_reader :games
  
  def initialize
    @games = []
  end 

  def create_games(database)
    contents = CSV.open database, headers: true, header_converters: :symbol 

    @games = contents.map do |game| 
      game_id = game[:game_id].to_i
      season = game[:season].to_i
      type = game[:type].to_s
      date_time = game[:date_time].to_s
      away_team_id = game[:away_team_id].to_i
      home_team_id = game[:home_team_id].to_i
      away_goals = game[:away_goals].to_i
      home_goals = game[:home_goals].to_i
      venue = game[:venue].to_s

      Game.new(game_id, season, type, date_time, away_team_id, home_team_id,away_goals, home_goals, venue)
    end
  end
end