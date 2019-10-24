require './lib/game_collection'
require './lib/team_collection'
require './lib/game_teams_collection'

class StatTracker

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]

    StatTracker.new(game_path, team_path, game_teams_path)
  end

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
  end

  def games
    GameCollection.new(@game_path)
  end

  def teams
    TeamCollection.new(@team_path)
  end

  def game_teams
    GameTeamsCollection.new(@game_teams_path)
  end

  def highest_total_score
    highest_total = games.game_objs.max_by{ |game| game.away_goals + game.home_goals }
    highest_total.away_goals + highest_total.home_goals
  end

  def lowest_total_score
    lowest_total = games.game_objs.min_by{ |game| game.away_goals + game.home_goals }
    lowest_total.away_goals + lowest_total.home_goals
  end

  def game_count_per_season
    hash = games.game_objs.reduce({}) do |game_count, game|
      if game_count[game.season]
        game_count[game.season] += 1
      else
        game_count[game.season] = 1
      end
      game_count
    end
    hash
  end

  def goal_count_per_season
    hash = games.game_objs.reduce({}) do |goal_count, game|
      if goal_count[game.season]
        goal_count[game.season] += (game.away_goals + game.home_goals)
      else
        goal_count[game.season] = (game.away_goals + game.home_goals)
      end
      goal_count
    end
    hash
  end

  def average_goals_by_season
    goal_count_per_season.merge(game_count_per_season) do |key, goal_count, game_count|
      (goal_count.to_f / game_count).round(2)
    end
  end

  # we want a method to count our games in a season, as well as total goals by season, and then merge those hashes and divide the values
end

