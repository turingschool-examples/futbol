require './lib/game'

class GamesCollection
  attr_reader :games

  def initialize(file_path)
    @games = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      game_id = row[:game_id]
      season = row[:season]
      type = row[:type]
      date_time = row[:date_time]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      venue = row[:venue]
      venue_link = row[:venue_link]
      @games << Game.new(game_id,season,type,date_time,away_team_id,home_team_id,away_goals,home_goals,venue,venue_link)
    end
  end
end
