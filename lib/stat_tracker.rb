require 'csv'
require_relative 'game'
class StatTracker
  def self.from_csv(locations)
    # .self is a class method that creates a new instance of StatTracker
    # require 'pry'; binding.pry
    # self.from_csv(locations): This class method reads CSV data from a file path specified in locations, 
    # processes each row into Games objects, and returns a new instance of StatTracker initialized with those objects.
    # returns a new instance of the class, typically initialized with the processed data
    games = []
    # This creates an empty array 'games' that will be used to store instances of the Games class created for CSV
    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      games << Game.new(row.to_h)
      # row.to_h converts A CSV row to a hash, key = headers, values = data drom the row
      # now we will have direct access to the keys, to be easier to read 
    endbranch
    
      #CSV.foreach -
    # it’s like flipping through each page of the book, 
    # turning the information into a special list, 
    # and making a new game from it, which we then add to our collection of games.
    # foreach is going to iterate over each row of the CSV file specified from locations[:games]
    # row_to_h turns the row into a hash, the hash is used to create new Games objects, games [] << Games objects
    # the return value is going to be an array of Game objects
    new(games)
    # require 'pry'; binding.pry
    # this is creating a new instance of StatTracker, passing the games [] to the initialize method of the class
  end

  def initialize(games)
    @games = games
    
  end



  def highest_total_score
    total_score.max
end

def lowest_total_score
    total_score.min
end

def total_score 
  # require 'pry' ;binding.pry
   @games.map do |game| #rows
    home_goals = game.home_goals
    away_goals = game.away_goals
    home_goals + away_goals
  end
end

def count_of_games_by_season
  count = Hash.new(0)
  @games.each do |game|
    count[game.season] += 1
  end
  count
end
end
