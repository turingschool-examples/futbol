require 'csv'
require_relative '../lib/game'
require 'csv'

class GameCollection
	attr_reader :games_array

	def initialize(location)
		@games_array = []
		CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
			@games_array << Game.new(row)
		end
	end

	def total_score
		total_score = @games_array.map do |game|
		game.home_goals.to_i + game.away_goals.to_i
		end
  end

  def home_wins
    home_wins = []

    @games_array.each do |game|
			if game.home_goals.to_i > game.away_goals.to_i
				home_wins << game
			end
    end
    home_wins
  end

  def visitor_wins
    visitor_wins = []

		@games_array.each do |game|
			if game.away_goals.to_i > game.home_goals.to_i
				visitor_wins << game
			end
		end
    visitor_wins
  end
	
  def ties
    ties = []

    @games_array.each do |game|
      if game.away_goals.to_i == game.home_goals.to_i
        ties << game
      end
    end
    ties
  end

  def count_of_games
    count_of_games_by_season = Hash.new {0}

    @games_array.each do |game|
      count_of_games_by_season[(game.season)] += 1
    end
    count_of_games_by_season
  end

  def average_goals_per_game
    sums = []

    @games_array.each do |game|
      sums << game.away_goals.to_f + game.home_goals.to_f
    end

    total_average = (sums.sum/@games_array.count).round(2)
  end

  def average_goals_by_season
    average_goals_by_season = Hash.new {0}
    total_goals_by_season = Hash.new {0}

    @games_array.each do |game|
      if total_goals_by_season[(game.season)] == nil
        total_goals_by_season[(game.season)] = game.away_goals.to_f + game.home_goals.to_f
      else
        total_goals_by_season[(game.season)] += game.away_goals.to_f + game.home_goals.to_f
      end
    end
  
    total_goals_by_season.each do |season, total_goals|
      average_goals_by_season[season] = (total_goals/count_of_games[season]).round(2)
    end
    
    average_goals_by_season
  end

	def game_ids_by_season
    game_ids_by_season = Hash.new{|k,v| k[v] = []} 
		@games_array.each do |game|
			game_ids_by_season[(game.season)] << (game.game_id)
    end
		game_ids_by_season
  end

	


end