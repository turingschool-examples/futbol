require_relative './csv_helper_file'

class GameRepository


  attr_reader :games_collection
  def initialize(file_path)
    @games_collection = CsvHelper.generate_game_array(file_path)
  end

  def highest_total_score
    highest_score = @games_collection.max_by do |game|
      #require 'pry'; binding.pry
      (game.away_goals + game.home_goals)
    end
    sum = (highest_score.away_goals + highest_score.home_goals)
  end


  def lowest_total_score
    lowest_score = @games_collection.min_by do |game|
      #require 'pry'; binding.pry
      (game.away_goals + game.home_goals)
    end
    sum = (lowest_score.away_goals + lowest_score.home_goals)
  end


end
