require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = locations[:games]
    teams = locations[:teams]
    game_teams = locations[:game_teams]
    stat_tracker = self.new(games, teams, game_teams)
  end

  def read_from_games_file
    file_open = CSV.open(@games)

    file_open.read
  end

  def read_from_teams_file
    file_open = CSV.open(@teams)

    file_open.read
  end

  def read_from_game_teams_file
    file_open = CSV.open(@game_teams)
    
    file_open.read
  end

end
