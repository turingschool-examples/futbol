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
  
  def total_games
    @games.count
    # binding.pry
  end

  # def ties
  #   game_teams.each {|game_team| game_team[:result]}
  #     if game_team == TIE 
  #   end
  # end

  # take game_teams -> HoA = home -> if win, +=1. Divide by total number of games, multiply by 100.
  # def percentage_home_wins
  #   home_team = []
  #   games_teams.each { |game_team| game_team[:HoA] }
  #     if game_team == home
  #       home_team << game_team
  #     end
  #     binding.pry
  # end
end