require './lib/stat_daddy'
require "csv"
require "pry"

# binding.pry
class GameStats < StatDaddy
  def highest_total_score
    highest_total_score = 0

    @games.each do |data|
      away_goals = data.away_goals.to_i
      home_goals = data.home_goals.to_i
      score = away_goals + home_goals

      highest_total_score = score if score > highest_total_score
    end
    highest_total_score
  end

  def lowest_total_score
    # By assigning Float::INFINITY we ensure that with each encounter during the iteration we set the new lowest total score to the new found summed scores encountered in the data
    lowest_total_score = Float::INFINITY

    @games.each do |data|
      away_goals = data.away_goals.to_i
      home_goals = data.home_goals.to_i
      score = away_goals + home_goals

      lowest_total_score = score if score < lowest_total_score
    end
    lowest_total_score
  end

  def percentage_home_wins
  end

  def percentage_visitor_wins
  end

  def percentage_ties
  end

  def count_of_games_by_season
  end

  def average_goals_per_game
  end

  def average_goals_by_season
  end
end
