require_relative './game'
require 'csv'

class GameCollection
attr_reader :games

  def create_games(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    csv.map do |row|
      Game.new(row)
    end
  end

  def initialize(csv_file_path)
    @games = create_games(csv_file_path)
  end

  def percentage_home_wins
    (@games.count {|game| game.home_goals > game.away_goals} / @games.size.to_f * 100).round(2)
  end

  def percentage_visitor_wins
    (@games.count {|game| game.away_goals > game.home_goals} / @games.size.to_f * 100).round(2)
  end

  def percentage_ties
     (@games.count {|game| game.away_goals == game.home_goals} / @games.size.to_f * 100).round(2)
  end

  def average_goals_by_season
    game_per_season = @games.group_by{|game| game.season}
    game_per_season.reduce({}) do |result, season|
      sum_goals = season[1].sum do |game| 
        game.away_goals + game.home_goals
      end
      result[season[0]] = (sum_goals/season[1].size.to_f).round(2)
      result
    end 
  end

  def highest_total_score
    highest_scoring_game = @games.max_by do |game|
      game.home_goals + game.away_goals
    end
    highest_scoring_game.home_goals + highest_scoring_game.away_goals
  end

  def lowest_total_score
    lowest_scoring_game = @games.min_by do |game|
      game.home_goals + game.away_goals
    end
    lowest_scoring_game.home_goals + lowest_scoring_game.away_goals
  end

  def biggest_blowout
    blowout = @games.max_by do |game|
      (game.home_goals - game.away_goals).abs
    end
    (blowout.home_goals - blowout.away_goals).abs
  end

  def games_per_season
    games_per_season_hash = @games.group_by {|game| game.season}
    games_per_season_hash.reduce({}) do |new_hash, game|
      new_hash[game[0]] = game[1].length
      new_hash
    end
  end
  
# average_goals_per_game	Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)	Float
end
