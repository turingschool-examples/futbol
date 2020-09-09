class GameStatistics
  attr_reader :stat_tracker

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def sum_team_scores
    grouping = {}
    total_score_data_set.map do |array|
      if grouping[array[0]].nil?
        grouping[array[0]] = array[1].to_i
      else
        grouping[array[0]] += array[1].to_i
      end
    end
    grouping
  end

  def total_score_data_set
    @stat_tracker[:game_teams]["game_id"].zip(@stat_tracker[:game_teams]["goals"])
  end

  def highest_total_score
    highest_game = sum_team_scores.max_by { |game_id, score| score }
    highest_game[1]
  end

  def lowest_total_score
    lowest_game = sum_team_scores.min_by { |game_id, score| score }
    lowest_game[1]
  end

  def home_away_data_set
    stat_tracker[:games]["home_goals"].zip(stat_tracker[:games]["away_goals"])
  end

  def percentage_home_wins
    (count_of_result("home").to_f / winners.length * 100).round(2)
  end

  def winners
    home_away_data_set.map do |pair|
      if pair[0].to_i - pair[1].to_i > 0
        "home"
      elsif pair[0].to_i - pair[1].to_i < 0
        "away"
      else
        "tie"
      end
    end
  end

  def count_of_result(result)
    winners.count do |winner|
      winner == result
    end
  end

  def percentage_visitor_wins
    (count_of_result("away").to_f / winners.length * 100).round(2)
  end

  def percentage_ties
    (count_of_result("tie").to_f / winners.length * 100).round(2)
  end

  def count_of_games_by_season
    games_per_season = stat_tracker[:games]["season"]
    seasonal_counts = {}
    games_per_season.each do |season|
      if seasonal_counts[season]
        seasonal_counts[season] += 1
      else
        seasonal_counts[season] = 1
      end
    end
    seasonal_counts
  end
end
