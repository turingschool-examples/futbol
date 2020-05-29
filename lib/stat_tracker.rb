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
    return_hash = {}
    @teams.all.each do |team|
      if team.team_id == team_id.to_s
        return_hash = team.to_hash
      end
    end
    return_hash
  end

  def best_season(team_id)
    myhash = @game_teams.all.find_all do |game_team|
      game_team.team_id == team_id.to_s
    end
    myhash.each do |item|
      binding.pry
      # hash[item[0]] = item[1]
    end

    p myhash
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
