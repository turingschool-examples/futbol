class StatTracker
  attr_reader :games, :teams, :games_teams

  def initialize(games, teams, games_teams)
    @games = games
    @teams = teams
    @games_teams = games_teams
  end

  def self.from_csv(locations)
    games = GamesCollection.new(generate_games_collection(locations[:games]))
    teams = TeamsCollection.new(generate_teams_collection(locations[:teams]))
    games_teams = GamesTeamsCollection.new(generate_games_teams_collection(locations[:games_teams]))
    self.new(games, teams, games_teams)
  end

  def self.generate_games_collection(games_csv_file_path)
  #start here!! make TESTTTT
  end

  def self.generate_teams_collection(teams_csv_file_path)
  end

  def self.generate_games_teams_collection(games_teams_csv_file_path)
  end
end
