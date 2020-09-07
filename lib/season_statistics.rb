require_relative "stat_tracker"

class SeasonStatistics
  attr_reader :stat_tracker_copy
  def initialize(csv_files, stat_tracker)
    @csv_game_teams_table = csv_files.game_teams
    @stat_tracker_copy = stat_tracker
    @coach_hash = coach_game_results
  end

  def coach_game_results
    coach_hash = {}
    @csv_game_teams_table.each do |key, value|
      if coach_hash[value.head_coach]
        coach_hash[value.head_coach] << value.result
      else
        coach_hash[value.head_coach] = [value.result]
      end
    end
    coach_hash
  end

  def winningest_coach
    winningest_coach_name = nil
    highest_percentage = 0
    @coach_hash.each do |key, value|
      total_games = 0
      total_wins = 0
      total_losses = 0
      total_ties = 0
      value.each do |game_result|
        total_games += 1
        if game_result == "WIN"
          total_wins += 1
        elsif game_result == "LOSS"
          total_losses += 1
        elsif game_result == "TIE"
          total_ties += 1
        end
      end
      # p " #{key} +  #{(total_wins.to_f / total_games).round(2)}"
      if (total_wins.to_f / total_games) > highest_percentage
        highest_percentage = (total_wins.to_f / total_games)
        winningest_coach_name = key
        # require "pry"; binding.pry/
      end
    end
    winningest_coach_name
  end

end
