require 'CSV'
# require './lib/game_manager'
# require './lib/team_manager'
# require './lib/game_teams_manager'
require './lib/game'
require './lib/game_teams'
require './lib/team'

class StatTracker

  attr_reader :games, :game_details, :teams

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(locations)
    @game_teams_array = []
    CSV.foreach(locations[:game_teams], headers: true) do |row|
      @game_teams_array << GameTeam.new(row)
    end

    @games_array = []
    CSV.foreach(locations[:games], headers: true) do |row|
      @games_array << Game.new(row)
    end

    @teams_array = []
    CSV.foreach(locations[:teams], headers: true) do |row|
      @teams_array << Team.new(row)
    end
  end

  def highest_total_score
    @all_goals_max = []
    @games_array.each do |game|
      total_goals = game.away_goals.to_i + game.home_goals.to_i
      @all_goals_max << total_goals
    end
    @all_goals_max.max
  end

  #
  def lowest_total_score
    @all_goals_min = []
    @games_array.each do |game|
      total_goals = game.away_goals.to_i + game.home_goals.to_i
      @all_goals_min << total_goals
    end
    @all_goals_min.min
  end
  #
  #   def find_team_id(team)
  #     results = @teams_file.find {|row| row[2] == team}
  #     results[0]
  #   end
  #
  #
  # #### Need to figure out how to un-chain method

  def percentage_home_wins
    home_games = []
    @game_teams_array.each do |game|
      if game.hoa.to_s == 'home'
        home_games << game
      end
    end
    home_wins = []
    home_games.each do |game|
      home_wins << game if game.result.to_s == 'WIN'
    end
    (home_wins.count.to_f/home_games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    home_games = []
    @game_teams_array.each do |game|
      if game.hoa.to_s == 'home'
      home_games << game
      end
    end
  home_losses = []
  home_games.each do |game|
    home_losses << game if game.result.to_s == 'LOSS'
  end
  (home_losses.count.to_f/home_games.count.to_f).round(2)
end





end
