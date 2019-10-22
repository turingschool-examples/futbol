class StatTracker
  attr_reader :games, :teams, :games_teams

  def initialize(games, teams, games_teams)
    @games = games
    @teams = teams
    @games_teams = games_teams
  end

  def self.from_csv(locations)
    games = GamesCollection.new
    teams = TeamsCollection.new
    games_teams = GamesTeamsCollection.new
    self.new(games, teams, games_teams)
  end
end
