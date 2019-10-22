class StatTracker
  attr_reader :games, :teams, :games_teams

  def initialize(locations_hash)
    @games = GamesCollection.new(locations_hash[:games])
    @teams = TeamsCollection.new(locations_hash[:teams])
    @games_teams = GamesTeamsCollection.new(locations_hash[:games_teams])
  end

  def self.from_csv(locations_hash)
    self.new(locations_hash)
  end
end
