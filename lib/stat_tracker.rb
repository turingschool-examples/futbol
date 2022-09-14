require 'csv'
require 'pry'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(csv_hash)
    games_input = CSV.read(csv_hash[:games], headers: true, header_converters: :symbol)
    teams_input = CSV.read(csv_hash[:teams], headers: true, header_converters: :symbol)
    game_teams_input = CSV.read(csv_hash[:game_teams], headers: true, header_converters: :symbol)
    stat_tracker = StatTracker.new(games_input, teams_input, game_teams_input)
  end
  #total_games is helper method used in percentage_ties & percentage_home_wins & percentage_visitor_wins
  #Recommend refactor?
  def total_games
    @games.count
  end
#percentage_ties is used to calclulate percentage of tie games
#Recommend combining percentage_ties, percentage_home_wins, percentage_visitor_wins methods using mixins or ?
  def percentage_ties
    ties = 0
    @games.each do |row|
      if [row[:away_goals]] == [row[:home_goals]]
       ties += 1
      end
    end
    (ties.to_f / @games.count).round(2)
  end
#percentage_ties is used to calclulate percentage of home wins
#Recommend combining percentage_ties, percentage_home_wins, percentage_visitor_wins methods using mixins or ?
  def percentage_home_wins
    home_wins = 0
   @games.each do |row|
      if row[:away_goals] < row[:home_goals]
        home_wins += 1
      end
    end
    (home_wins.to_f / @games.count).round(2)
  end
#percentage_ties is used to calclulate percentage of visitor wins
#Recommend combining percentage_ties, percentage_home_wins, percentage_visitor_wins methods using mixins or ?
  def percentage_visitor_wins
    visitor_wins = 0
   @games.each do |row|
      if row[:away_goals] > row[:home_goals]
        visitor_wins += 1
      end
    end
    (visitor_wins.to_f / @games.count).round(2)
  end
end