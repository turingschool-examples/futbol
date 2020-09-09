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
    data_set = @stat_tracker[:game_teams]["HoA"].zip(@stat_tracker[:game_teams]["result"])
      grouping = {}
      data_set.map do |pair|
        if grouping[pair[0]].nil?
          grouping[pair[0]] = {
            if pair[1].nil?
              pair[1] = 1
            else
              pair[1] += 1
            end
          }
        else
          grouping[pair[0]] += 1.0
        end
      end
      something_else = {}
      data_set.map do |pair|
        if something_else[pair[1]].nil?
          something_else[pair[1]] = 1.0
        else
          something_else[pair[1]] += 1.0
        end
      end
    binding.pry
  end
end
