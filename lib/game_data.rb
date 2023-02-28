require 'csv'

class GameData 

attr_reader :games

  def initialize
    @games = []
  end

  def add_games 
    games = CSV.open 'data/games.csv', headers: true, header_converters: :symbol
    games.each do |row|
      id = row[:game_id]
      season = row[:season]
      type = row[:type]
      date_time = row[:date_time]
      away = row[:away_team_id]
      home = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      venue = row[:venue]
      venue_link = row[:venue_link]
      @games << Game.new(id, season, type, date_time, away, home, away_goals, home_goals, venue, venue_link)
    end
  end
end