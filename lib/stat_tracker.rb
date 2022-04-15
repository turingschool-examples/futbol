require "csv"
require './lib/game'
require './lib/team'
require './lib/game_teams'

class StatTracker
  attr_reader :games, :teams, :game_teams, :games_array

  def initialize(locations)
    @game_data = CSV.read(locations[:games], headers:true,
       header_converters: :symbol)
    @team_data = CSV.read(locations[:teams], headers:true,
       header_converters: :symbol)
    @game_team_data = CSV.read(locations[:game_teams],
       headers:true, header_converters: :symbol)
    # @games_array = []
    @games = Game.fill_game_array(@game_data)
    @teams = Team.fill_team_array(@team_data)
    @game_teams = GameTeams.fill_game_teams_array(@game_team_data)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score(game_data)
    sum = 0
    highest_sum = 0
    game_data.each do |game|
      sum = game.away_goals.to_i + game.home_goals.to_i
      #require 'pry'; binding.pry
      highest_sum = sum if sum > highest_sum
    end
    highest_sum
  end

  # def count_of_teams
  #   require 'pry'; binding.pry
  #   @teams.count
  # end

  end
