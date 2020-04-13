require_relative './csv_helper_file'

class GameRepository


  attr_reader :games_collection
  def initialize(file_path)
    @games_collection = CsvHelper.generate_game_array(file_path)
    @game_team_collection = CsvHelper.generate_game_teams_array(file_path)
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
      (game.away_goals + game.home_goals)
    end
      sum = (lowest_score.away_goals + lowest_score.home_goals)
  end


  def percentage_home_wins
    number_of_games = @games_collection.length
  home_wins =  @games_collection.select do |game|
      game.home_goals > game.away_goals
    end
    number_of_homewins = home_wins.length
    percent_home_wins = (number_of_homewins.to_f / number_of_games.to_f).round(2)
  end

  def percentage_visitor_wins
    number_of_games = @games_collection.length
  visitor_wins =  @games_collection.select do |game|
      game.home_goals < game.away_goals
    end
    number_of_visitor = visitor_wins.length
    percent_visitor_wins = (number_of_visitor.to_f / number_of_games.to_f).round(2)
  end

  def percentage_ties
    number_of_games = @games_collection.length
  ties =  @games_collection.select do |game|
      game.home_goals == game.away_goals
    end
    number_of_ties = ties.length
    percent_ties = (number_of_ties.to_f / number_of_games.to_f).round(2)
  end

  def average_goals_per_game
    total_goals = @games_collection.sum do |game|
      (game.home_goals + game.away_goals)
    end
    (total_goals.to_f / @games_collection.length).round(2)
  end

  def average_goals_by_season
    seasons = @games_collection.map do |game|
      [game.game_id, game.season]
    end
      tally = 0
    average = @game_team_collection.map do |game|
      if seasons[1][0] == game.game_id
        tally += game.goals
      end

    end
    goals_by_season
  end

  def count_of_games_by_season
    games_by_season = Hash.new
    total_games = 1
    seasons = @games_collection.each do |game|
      if games_by_season[game.season] == nil
        games_by_season[game.season] = 1
      else
        games_by_season[game.season] += 1
      end
    end
    games_by_season
  end

end
