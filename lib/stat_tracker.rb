require "csv"
class StatTracker
	attr_accessor :game_teams,
                :games,
                :teams

	def initialize(locations)
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol 
    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
	end
  
	def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    total_score = []
    games.each do |game|
      total_score << game[:home_goals].to_i + game[:away_goals].to_i
    end
    total_score.max
  end
end