require 'pry'
require 'CSV'
require './lib/games_collection'

class StatTracker
  attr_reader :locations

  def initialize(locations)
    @locations = locations
    # @read_games = ()
    @games_file = GamesCollection.new(@locations[:games])
    @read_games = @games_file.read_file
  end
  # def setup
  # end

  def self.from_csv(locations) #add .to_a changes to an array\
    #binding.pry
    StatTracker.new(locations) #creating an instance of StatTracker holding the hash as locations
  end


  def highest_total_score
    scores_array = []
    @read_games.each do |row|
      # binding.pry
      scores_array << (row.away_goals.to_i + row.home_goals.to_i)
    end
    scores_array.max
  end

  def lowest_total_score
    scores_array = []
    @read_games.each do |row|
      scores_array << row.away_goals.to_i + row.home_goals.to_i
    end
    scores_array.min
  end

  def percentage_home_wins
    games_played = 0
    wins = 0
     @read_games.each do |game|
       # binding.pry
      if game.home_goals.to_i > game.away_goals.to_i
        # binding.pry
        games_played += 1
        wins += 1
      elsif
        games_played += 1
      end
    end
      (wins.to_f / games_played.to_f).round(2)
  end

  # def percentage_visitor_wins
  #    @read_games.each do |game|
  #     if game.away_goals.to_i > game.home_goals.to_i
  #       games_played += 1
  #       wins += 1
  #     elsif
  #       games_played += 1
  #     end
  #   end
  #   binding.pry
  #     (wins.to_f / games_played.to_f).round(2)
  # end
end


# locations.each do |location|
#   location.key.to_s = StatTracker.new(location.value)
#   binding.pry
# end
