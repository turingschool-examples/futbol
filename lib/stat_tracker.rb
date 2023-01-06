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

  def total_score
    total_score = games.map do |game|
      game[:home_goals].to_i + game[:away_goals].to_i
    end
  end

  def highest_total_score
    total_score.max
  end

  def lowest_total_score
    total_score.min
  end

  def count_of_games_by_season
    count_of_games_by_season = Hash.new {0}

    games[:season].each do |season|
      count_of_games_by_season[season] += 1
    end
    
    count_of_games_by_season
  end

  def average_goals_per_game
    sums = []
    i = 0
    while i < games.count
      sums << games[:away_goals][i].to_f + games[:home_goals][i].to_f
      i += 1
    end
    total_average = (sums.sum/games.count).round(2)
  end

  def average_goals_by_season
    average_goals_by_season = Hash.new {0}
  end
end