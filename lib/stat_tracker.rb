require 'CSV'

class StatTracker
  attr_reader  :games, :teams, :game_teams 
             
  def initialize(locations)
    @games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    highest_score = []
    @games.sum do |data|
      highest_score << [(data[:away_goals].to_i + data[:home_goals].to_i)]

    end
  end
end     




