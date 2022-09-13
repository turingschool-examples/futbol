require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
   games = CSV.open locations[:games], headers: true, header_converters: :symbol
   teams = CSV.open locations[:teams], headers: true, header_converters: :symbol
   game_teams = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
   make_rows(games, teams, game_teams)
  end

  def self.make_rows(games, teams, game_teams)
    
    games_rows = []

    games.each do |row|
      games_rows << row
    end
    require 'pry'; binding.pry
    StatTracker.new(games_rows, teams, game_teams)

  end
end