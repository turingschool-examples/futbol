require "csv"
require_relative "./games"

class GameStatisticsCollection
  attr_reader :collection,
              :csv_location

  def initialize(csv_location)
    @collection = []
    @csv_location = csv_location
  end

  def load_games
    CSV.foreach(@csv_location, :headers => true, :header_converters => :symbol) do |row|
        game_id = row[:game_id].to_i
        season = row[:season]
        type = row[:type]
        date_time = row[:date_time]
        away_team_id = row[:away_team_id].to_i
        home_team_id = row[:home_team_id].to_i
        away_goals = row[:away_goals].to_i
        home_goals = row[:home_goals].to_i
        venue = row[:venue]
        venue_link = row[:venue_link]

      @collection << Games.new({:game_id => game_id, :season=> season, :type=> type, :date_time => date_time, :away_team_id => away_team_id, :home_team_id=> home_team_id, :away_goals => away_goals, :home_goals => home_goals, :venue => venue, :venue_link => venue_link})
    end
  end
end
