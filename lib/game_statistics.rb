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

  def percentage_home_wins
    game_pairs = stat_tracker[:games]["home_goals"].zip(stat_tracker[:games]["away_goals"])
    winners = game_pairs.map do |pair|
      if pair[0].to_i - pair[1].to_i > 0
        "home"
      elsif pair[0].to_i - pair[1].to_i < 0
        "away"
      else
        "tie"
      end
    end
    winners_number = winners.count do |winner|
      winner == "home"
    end
    (winners_number.to_f / winners.length * 100).round(2)
  end

  def percentage_visitor_wins
  game_pairs = stat_tracker[:games]["home_goals"].zip(stat_tracker[:games]["away_goals"])
    winners = game_pairs.map do |pair|
      if pair[0].to_i - pair[1].to_i > 0
        "home"
      elsif pair[0].to_i - pair[1].to_i < 0
        "away"
      else
        "tie"
      end
    end
    winners_number = winners.count do |winner|
      winner == "away"
    end
    (winners_number.to_f / winners.length * 100).round(2)
  end

  def percentage_ties
    game_pairs = stat_tracker[:games]["home_goals"].zip(stat_tracker[:games]["away_goals"])
    winners = game_pairs.map do |pair|
      if pair[0].to_i - pair[1].to_i > 0
        "home"
      elsif pair[0].to_i - pair[1].to_i < 0
        "away"
      else
        "tie"
      end
    end
    winners_number = winners.count do |winner|
      winner == "tie"
    end
    (winners_number.to_f / winners.length * 100).round(2)
  end
end
