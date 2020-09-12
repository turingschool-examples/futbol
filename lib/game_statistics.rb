class GameStatistics
  attr_reader :stat_tracker

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  # def initialize(data, games_manager)
  #   @data =
  #   @games_manager = games_manager
  # end

  def sum_team_scores
    grouping = {}
    total_score_data_set.map do |set|
      if grouping[set[0]].nil?
        grouping[set[0]] = set[1].to_i
      else
        grouping[set[0]] += set[1].to_i
      end
    end
    grouping
  end

  def adding_goals_per_game
    home_away_data_set.map do |numbers|
      numbers.sum do |number|
        number.to_i
      end
    end
  end

  def total_score_data_set
    @stat_tracker[:games]["game_id"].zip(adding_goals_per_game)
  end

  # def highest_total_score
  #   highest_game = sum_team_scores.max_by { |game_id, score| score }
  #   highest_game[1]
  # end

  # def lowest_total_score
  #   lowest_game = sum_team_scores.min_by { |game_id, score| score }
  #   lowest_game[1]
  # end

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
end
