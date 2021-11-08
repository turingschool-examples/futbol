require './lib/stat_tracker'
require './lib/games_modules'

class GamesData
  include GamesEnumerables
  attr_reader :game_data

  def initialize(current_stat_tracker)
    @game_data = current_stat_tracker.games
  end

  def highest_total_score
    highest_score = 0
    @game_data.each do |row|
      total_score = row['away_goals'].to_i + row['home_goals'].to_i
      if total_score > highest_score
        highest_score = total_score
      end
    end
    highest_score
  end

  def lowest_total_score
    lowest_score = 100
    @game_data.each do |row|
      total_score = row['away_goals'].to_i + row['home_goals'].to_i
      if total_score < lowest_score
        lowest_score = total_score
      end
    end
    lowest_score
  end

  def percentage_home_wins
    win_counter = 0
    @game_data.each do |row|
      if row['home_goals'].to_i > row['away_goals'].to_i
        win_counter += 1
      end
    end
    return_percentage(win_counter, @game_data)
  end

  def percentage_visitor_wins
    win_counter = 0
    @game_data.each do |row|
      if row['home_goals'].to_i < row['away_goals'].to_i
        win_counter += 1
      end
    end
    return_percentage(win_counter, @game_data)
  end

  def percentage_ties
    tie_counter = 0
    @game_data.each do |row|
      if row['home_goals'].to_i == row['away_goals'].to_i
        tie_counter += 1
      end
    end
    return_percentage(tie_counter, @game_data)
  end

  def sum_of_games_in_season(season_number)
    season_games = @game_data.select do |row|
      row['season'] == season_number
    end
    season_games.count
  end

  def count_of_games_by_season
    new_hash = {}
    keys = @game_data.map do |row|
      row['season']
    end.flatten.uniq

    keys.each do |key|
      new_hash[key] = sum_of_games_in_season(key)
    end
    new_hash
  end

  def average_goals_per_game
    goal_counter = 0
    @game_data.each do |row|
      goal_counter += (row['away_goals'].to_f + row['home_goals'].to_f)
    end
    get_average(goal_counter, @game_data)
  end


  def average_goals(season)

    new_array = @game_data.select do |row|
      row['season'] == season
    end
    goals = 0
    new_array.each do |row|
      goals += (row['away_goals'].to_f + row['home_goals'].to_f)
    end

    (goals / sum_of_games_in_season(season)).round(2)
  end

  def average_goals_by_season
    goal_counter = 0
    new_hash = {}

    keys = @game_data.map do |row|
      row['season']
    end.flatten.uniq

    keys.each do |key|
      new_hash[key] = average_goals(key)
    end

    new_hash
  end

end
