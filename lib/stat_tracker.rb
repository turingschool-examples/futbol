require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './game_collection'
require 'CSV'


class StatTracker
  attr_reader :games, :teams, :game_teams, :game_file, :team_file

  def self.from_csv(locations)
    game_file = locations[:games]
    team_file = locations[:teams]
    game_teams_file = locations[:game_teams]

    game_collection = GameCollection.load_data(game_file)
    team_collection = TeamCollection.load_data(team_file)
    require "pry"; binding.pry
    StatTracker.new(game_collection, team_file, game_teams_file)
  end

  def initialize(game_collection, team_file, game_teams_file)
    @game_collection = game_collection
    @team_file = team_file
    @game_teams_file = game_teams_file
  end

  def highest_total_score
    highest = @games.max_by do |game|
      game.away_goals + game.home_goals
    end
    highest.away_goals + highest.home_goals
  end

  def lowest_total_score
    lowest = @games.min_by do |game|
      game.away_goals + game.home_goals
    end
    lowest.away_goals + lowest.home_goals
  end

  def biggest_blowout
    biggest = @games.max_by do |game|
      (game.away_goals - game.home_goals).abs
    end
    (biggest.away_goals - biggest.home_goals).abs
  end
end
