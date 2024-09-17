require './lib/game'
class GameFactory
  attr_reader :games

  def initialize
    @games = []
  end

  def create_games(source)
    CSV.foreach(source, headers: true, header_converters: :symbol) do |row|
      game_id = row[:game_id]
      season = row[:season]
      type = row[:type]
      date_time = row[:date_time]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      venue = row[:venue]
      venue_link = row[:venue_link]
      @games << Game.new(row)
    end
  end
end
