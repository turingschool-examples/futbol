require './lib/stat_tracker'

class GamesData < StatTracker

  attr_reader :game_data

  def initialize(current_stat_tracker)
    @game_data = current_stat_tracker.games
    # @game_id = @game_data["game_id"]
    # @season = @game_data["season"]
    # @type = @game_data["type"]
    # @data_time = @game_data["date_time"]
    # away_team_id = @game_data["away_team_id"]
    # home_team_id = @game_data["home_team_id"]
    # away_goals = @game_data["away_goals"].to_i
    # home_goals = @game_data["home_goals"].to_i
    # venue = @game_data["venue"]
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
    ((win_counter.to_f / @game_data.length) * 100).round(2)
  end

  def percentage_visitor_wins
    win_counter = 0
    @game_data.each do |row|
      if row['home_goals'].to_i < row['away_goals'].to_i
        win_counter += 1
      end
    end
    ((win_counter.to_f / @game_data.length) * 100).round(2)
  end

  def percentage_ties
    tie_counter = 0
    @game_data.each do |row|
      if row['home_goals'].to_i == row['away_goals'].to_i
        tie_counter += 1
      end
    end
    ((tie_counter.to_f / @game_data.length) * 100).round(2)
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

end
