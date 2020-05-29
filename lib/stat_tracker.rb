require "csv"
require "./lib/game_collection"
require "./lib/team_collection"
require "./lib/game_team_collection"
require "./lib/team"

class StatTracker

  def initialize(location)
    @games = GameCollection.new(location[:games])
    @teams = TeamCollection.new(location[:teams])
    @game_teams = GameTeamCollection.new(location[:game_teams])
  end
  def self.from_csv(location)
    StatTracker.new(location)
  end

  def games
    @games.all
  end

  def teams
    @teams.all
  end

  def game_teams
    @game_teams.all
  end

  def team_info(team_id)
    # uses teams.csv
    return_hash = {}
    @teams.all.each do |team|
      if team.team_id == team_id.to_s
        return_hash = team.to_hash
      end
    end
    return_hash
  end

  def best_season(team_id)
    # uses game_teams.csv and games.csv
    game_teams_array = []
    games_array = []
    combined_array = []
    combined = {}
    counter = 0
    @game_teams.all.each do |game_team|
      if game_team.team_id == team_id.to_s
        game_teams_array << game_team.to_hash
      end
    end
    @games.all.each do |game|
      if game.home_team_id == team_id.to_s || game.away_team_id == team_id.to_s
        games_array << game.to_hash
      end
    end
    #combines arrays created from game_teams.csv and games.csv
    games_array.each do |game|

      game_teams_array.each do |game_team|
        p game_team[:game_id]
        if game_team[:game_id] == game[:game_id]
          p "game #{game[:game_id]}"
          p "game team #{game_team[:game_id]} #{game_team[:result]}"
          counter = counter + 1
          combined[:number] = counter
          combined[:game_id] = game[:game_id]
          combined[:result] = game_team[:result]
          combined[:season] = game[:season]
        end

      end
      combined_array << combined
      p combined_array
      p combined
    end
  end

  # def worst_season
  #   #String
  #   # Season with the lowest win percentage for a team.
  # end
  #
  # def average_win_percentage
  #   #Float
  #   # Average win percentage of all games for a team.
  # end
  #
  # def most_goals_scored
  #   #Integer
  #   # Highest number of goals a particular team has scored in a single game.
  # end
  #
  # def fewest_goals_scored
  #   #Integer
  #   # Lowest numer of goals a particular team has scored in a single game.
  # end
  #
  # def favorite_opponent
  #   #String
  #   # Name of the opponent that has the lowest win percentage against the given
  #   # team.
  # end
  #
  # def rival
  #   #String
  #   # Name of the opponent that has the highest win percentage against the
  #   # given team.
  # end

end
