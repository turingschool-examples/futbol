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

  def goals_per_game_data_set
    stat_tracker[:games]["game_id"].zip(home_away_data_set)
  end

  def total_goals_per_game
    goals_per_game_data_set.map do |game|
      game[1].map do |score|
        score[0].to_i + score[1].to_i
      end
    end
  end

  def count_of_total_goals
    total_goals_per_game.reduce(0) do |total, game|
      total += (game[0] + game[1])
    end
  end

  def average_goals_per_game
    (count_of_total_goals.to_f / stat_tracker[:games]["game_id"].count).round(2)
  end

  def total_goals_per_season
    goals_per_season = {}
    seasons = stat_tracker[:games]["season"].zip(home_away_data_set)
    seasons.map do |season|
      if goals_per_season[season[0]].nil?
         goals_per_season[season[0]] = (season[1][0].to_f + season[1][1].to_f)
      else
         goals_per_season[season[0]] += (season[1][0].to_f + season[1][1].to_f)
      end
    end
    goals_per_season
  end

  def average_goals_by_season
    average = {}
    total_goals_per_season.map do |season_id, total_goals|
      average[season_id] = (total_goals / count_of_games_by_season[season_id])
    end
    average
  end

  def count_of_teams
    stat_tracker[:teams]["team_id"].count
  end

  def team_id_team_name_data_set
    stat_tracker[:teams]["team_id"].zip(stat_tracker[:teams]["teamName"])
  end

  def find_best_offense
    offense_list.max_by do |team_id, avg_goals_per_game|
      avg_goals_per_game
    end.to_a
  end

  def best_offense
    name = team_id_team_name_data_set.find do |set|
      if set[0] == find_best_offense[0]
        team_id_team_name_data_set
      end
    end
    name[1]
  end

  def offense_list
    offense_list = {}
    games_per_team.each do |team_id, number_games|
      offense_list[team_id] = total_points_by_team[team_id].to_f / number_games
    end
    offense_list
  end

  def games_per_team #team_id => total_games_in_a_season
    count_teams = {}
    stat_tracker[:teams]["team_id"].each do |team_number|
      count_teams[team_number] = count_of_teams do |team_id|
        team_id == team_number
      end
    end
    count_teams
  end

  def team_goals_data_set
    stat_tracker[:game_teams]["team_id"].zip(stat_tracker[:game_teams]["goals"])
  end

  def total_points_by_team
    grouping = {}
    team_goals_data_set.each do |array|
      if grouping[array[0]].nil?
        grouping[array[0]] = array[1].to_i
      else
        grouping[array[0]] += array[1].to_i
      end
      # require 'pry';binding.pry
    end
    grouping
  end
  # def total_goals_per_team
  #   team_goals = {}
  #   stat_tracker[:game_teams]["team_id"].each do |team_id|
  #     team_goals[team_id] = stat_tracker[:game_teams]["goals"].each do |goal|
  #       if team_goals[team_id]
  #         # require 'pry';binding.pry
  #         team_goals[team_id] += goal.to_i
  #       else
  #         team_goals[team_id] = goal.to_i
  #       end
  #     end
  #   end
  #   team_goals
  # end
end
