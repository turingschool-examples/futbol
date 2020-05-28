require "csv"
require "./lib/game"
require "./lib/team"
require "./lib/game_team"

class StatTracker
  @@games = []
  @@teams = []
  @@game_teams = []
  def self.from_csv(location)
    games_data = CSV.read(location[:games], headers: true, header_converters: :symbol)
    @@games = games_data.map do |row|
      Game.new(row)
     end

    teams_data = CSV.read(location[:teams], headers: true, header_converters: :symbol)
    @@teams = teams_data.map do |row|
      Team.new(row)
    end

    game_teams_data = CSV.read(location[:game_teams], headers: true, header_converters: :symbol)
    @@game_teams = game_teams_data.map do |row|
      GameTeam.new(row)
    end

    StatTracker.new
  end

  def games
    @@games
  end

  def teams
    @@teams
  end

  def game_teams
    @@game_teams
  end

  def team_info
    #Hash
    # A hash with key/value pairs for the following attributes: team_id,
    # franchise_id, team_name, abbreviation, and link	Hash
    myhash = {}

    @@teams.map do |team|
      p team.to_hash
    end
  end

  def best_season
    #String
    # Season with the highest win percentage for a team.
  end

  def worst_season
    #String
    # Season with the lowest win percentage for a team.
  end

  def average_win_percentage
    #Float
    # Average win percentage of all games for a team.
  end

  def most_goals_scored
    #Integer
    # Highest number of goals a particular team has scored in a single game.
  end

  def fewest_goals_scored
    #Integer
    # Lowest numer of goals a particular team has scored in a single game.
  end

  def favorite_opponent
    #String
    # Name of the opponent that has the lowest win percentage against the given
    # team.
  end

  def rival
    #String
    # Name of the opponent that has the highest win percentage against the
    # given team.
  end

end
