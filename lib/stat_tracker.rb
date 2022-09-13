require 'csv'

class StatTracker
  attr_reader :games, 
              :teams,
              :game_teams

  def initialize
    @games = CSV.read './data/games.csv', headers: true, header_converters: :symbol
    @teams = CSV.read './data/teams.csv', headers: true, header_converters: :symbol
    @game_teams = CSV.read './data/game_teams.csv', headers: true, header_converters: :symbol
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  # def return_game_id
  #   game_id = []
  #   @games.each do |game|
  #     game_id << 
  #   end
  # end
end



