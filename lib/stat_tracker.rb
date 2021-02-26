require 'CSV'

class StatTracker
  attr_reader :games_manager

  def initialize(locations)
    @locations = locations
    # @team_manager = TeamsManager.new(load_csv(locations[:teams]), self)
    @games_manager = GamesManager.new(CSV.parse(File.read(locations[:games]), headers: true, header_converters: :symbol), self)
    # @game_team_manager = GameTeamsManager.new(load_csv(locations[:game_teams]), self)
  end


  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end
