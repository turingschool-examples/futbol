require 'csv'
require './lib/game'
require './lib/season'
require './lib/team_tracker'

class GameTracker
  attr_reader :games

  def initialize
    @@games = create
  end

  def self.create
    games = []
    contents = CSV.open './data/games_stub.csv', headers:true, header_converters: :symbol
    contents.each do |row|
      game_id = row[:game_id]
      type = row[:type]
      date_time = row[:date_time]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      venue = row[:venue]
      venue_link = row[:venue_link]
      season = row[:season]
      games << Game.new(game_id,type,date_time,away_team_id,home_team_id,away_goals,home_goals,venue,venue_link,season)
    end
    games
  end
end
#p GameTracker.create
