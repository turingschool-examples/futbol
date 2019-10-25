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

  def count_of_games_per_season
    game.count_of_games_per_season
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

  def average_goals_per_season
    game.average_goals_per_season
  end

  def percentage_vistor_wins
    game_team.percentage_vistor_wins
  end

  def percentage_home_wins
    game_team.home_wins / game.length.to_f
  end

  def percentage_ties
    game.percentage_ties
  end
end
