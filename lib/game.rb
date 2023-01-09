require 'csv'

class Game 
   attr_reader :game_path 

  def initialize(file_path)
    @game_path = file_path
  end

  def all_scores #HELPER for highest_total_score and lowest_total_score
    @game_path.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
  end

  def highest_total_score 
    all_scores.max
  end

  def lowest_total_score 
    all_scores.min
  end

  def home_wins_array #HELPER for percentage_home_wins/ #move to game class
    @game_path.find_all do |row|
     row[:home_goals].to_i > row[:away_goals].to_i
    end
  end

  def percentage_home_wins #move to game class
    wins = home_wins_array.count
    (wins.to_f / @game_path.count).round(2)
  end

  def visitor_wins_array #HELPER for percentage_visitor_wins/ #move to game class
    @game_path.find_all do |row|
        row[:away_goals].to_i > row[:home_goals].to_i
    end
  end

  def percentage_visitor_wins #move to game class
    visitor_wins = visitor_wins_array.count
    (visitor_wins.to_f / @game_path.count).round(2)
  end

	def ties_array #Helper percentage_ties / #move to game class
		@game_path.find_all do |row|
			row[:away_goals].to_i == row[:home_goals].to_i
		end
	end

	def percentage_ties #move to game class
		ties = ties_array.count
		(ties.to_f / @game_path.count).round(2)
	end

	def count_of_games_by_season #move to game class
		season_id = @game_path.group_by { |row| row[:season] }
		season_id.each do |season, game|
			season_id[season] = game.count
		end
	end
   
  def average_goals_per_game #move to game class
    (all_scores.sum / @game_path.count.to_f).round(2)
  end

  def average_goals_by_season #move to game class
    games_group_by_season = @game_path.group_by { |row| row[:season] }
    average_season_goals = {}
    games_group_by_season.each do |season, games|
     total_goals = games.sum do |game|
        game[:away_goals].to_i + game[:home_goals].to_i
      end
      average_season_goals[season] = (total_goals / games.count.to_f).round(2)
    end
    average_season_goals
  end
end