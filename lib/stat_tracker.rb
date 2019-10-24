require_relative './game_collection'
require_relative './team_collection'
require_relative './game_team_collection'
require 'pry'

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
    @games = GameCollection.new(@game_path)
    @teams = TeamCollection.new(@team_path)
    @game_teams = GameTeamCollection.new(@game_teams_path)
  end

  def highest_total_score
    highest_total = @games.games.max_by{ |game| game.away_goals + game.home_goals }
    highest_total.away_goals + highest_total.home_goals
  end

  def lowest_total_score
    lowest_total = @games.games.min_by{ |game| game.away_goals + game.home_goals }
    lowest_total.away_goals + lowest_total.home_goals
  end

  def biggest_blowout
    blowout = @games.games.max_by { |game| (game.home_goals - game.away_goals).abs }
    (blowout.home_goals - blowout.away_goals).abs
  end

  def percent_home_wins
    h_win = @games.games.count { |game| game.away_goals < game.home_goals }
    ((h_win * 100.00).to_f / @games.games.length).round(2)
  end

  def percent_visitor_wins
    v_win = @games.games.count { |game| game.away_goals > game.home_goals }
    ((v_win * 100.00).to_f / @games.games.length).round(2)
  end

  def percent_ties
    ties = @games.games.count { |game| game.away_goals == game.home_goals }
    ((ties * 100.00).to_f / @games.games.length).round(2)
  end

  def game_count_per_season
    hash = @games.games.reduce({}) do |game_count, game|
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
    hash = @games.games.reduce({}) do |goal_count, game|
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

<<<<<<< HEAD
  def count_of_games_by_season
    games.game_objs.reduce({}) do |games_by_season, game|
      games_by_season[game.season] = "tbd"
      #need helper method for finding all games from that season and counting them (array.length)
        games_by_season
      end
  end

end
=======

>>>>>>> cf7f2a9d2d6b83389d296e241e9981d6586d1d7b
