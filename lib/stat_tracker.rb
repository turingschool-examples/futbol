class StatTracker
  attr_reader :games, :teams, :games_teams

  def initialize(file_paths)
    @games = GamesCollection.new(file_paths[:games])
    @teams = TeamsCollection.new(file_paths[:teams])
    @games_teams = GamesTeamsCollection.new(file_paths[:games_teams])
  end

  def self.from_csv(file_paths)
    self.new(file_paths)
  end
end
