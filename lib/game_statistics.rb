# require './lib/stat_tracker.rb'

module GameStatistics

  def unique_total_goals
    goal_totals = []
      @games.each do |game_id, game_data|
        if goal_totals.include?(game_data.away_goals + game_data.home_goals) == false
          goal_totals << game_data.away_goals + game_data.home_goals
        end
      end
    goal_totals
  end

  def highest_total_score
    unique_total_goals.max
  end

  def lowest_total_score
    unique_total_goals.min
  end

  def percentage_home_wins
    counter = 0
    @games.each do |game_id, game_data|
      if game_data.home_team[:result] == "WIN"
        counter += 1
      end
    end
    (counter.to_f/total_number_of_games).round(2)
  end

  def total_number_of_games
    @games.keys.size
  end

  def percentage_visitor_wins
    counter = 0
    @games.each do |game_id, game_data|
      if game_data.away_team[:result] == "WIN"
        counter += 1
      end
    end
    (counter.to_f/total_number_of_games).round(2)
  end

  def percentage_ties
    counter = 0
    @games.each do |game_id, game_data|
      if game_data.away_team[:result] == "TIE"
        counter += 1
      end
    end
    (counter.to_f/total_number_of_games).round(2)
  end

  def count_of_games_by_season
    seasons = Hash.new(0)
    @games.each do |game_id, game_data|
      seasons[game_data.season] += 1
    end
    seasons
  end

  def average_goals_per_game
    total_goals = 0
    @games.each do |game_id, game_data|
      total_goals += (game_data.away_goals.to_f + game_data.home_goals.to_f)
    end
    (total_goals / total_number_of_games).round(2)
  end

  def goals_by_season
    goals_per_season = Hash.new(0)
    @games.each do |game_id, game_data|
      goals_per_season[game_data.season] += (game_data.away_goals.to_f + game_data.home_goals.to_f)
    end
    goals_per_season
  end

  def average_goals_by_season
    average_goals_per_season = Hash.new(0)
      goals_by_season.each do |season, goals|
        # require "pry"; binding.pry
        average_goals_per_season[season] = (goals/(count_of_games_by_season[season])).round(2)
      end
    average_goals_per_season
  end
end
