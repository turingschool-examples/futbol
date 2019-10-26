require_relative 'game_teams_collection'
require_relative 'team_collection'
require_relative 'game_collection'

require 'csv'

class StatTracker

    def self.from_csv(locations)
      StatTracker.new(locations)
    end

    def initialize(locations)
      @game_path = locations[:games]
      @team_path = locations[:teams]
      @game_teams_path = locations[:game_teams]
    end

    def game
      GameCollection.new(@game_path)
    end

    def game_teams
      GameTeamsCollection.new(@game_teams_path)
    end

    def team
      TeamCollection.new(@team_path)
    end

  def highest_total_score
    game.highest_total_score
  end

  def count_of_games_by_season
    game.count_of_games_by_season
  end

  def lowest_total_score
    game.lowest_total_score
  end

  def biggest_blowout
    game.biggest_blowout
  end

  def average_goals_per_game
    game.average_goals_per_game
  end

  def average_goals_by_season
    game.average_goals_by_season
  end

  def percentage_visitor_wins
    (game.visitor_wins / game.game_instances.length.to_f).round(2)
  end

  def percentage_home_wins
    (game.home_wins / game.game_instances.length.to_f).round(2)
  end

  def percentage_ties
    (game.ties / game.game_instances.length.to_f).round(2)
  end

  def count_of_teams
    team.count_of_teams
  end
end
