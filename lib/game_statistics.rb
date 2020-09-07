require_relative "stat_tracker"

class GameStatistics
  attr_reader :stat_tracker
  def initialize(csv_files,stat_tracker)
    @game_files = csv_files.games
    @stat_tracker = stat_tracker
  end

  def highest_total_score
    highest_total = 0
    @game_files.each do |key, value|
      total = value.away_goals + value.home_goals
      if total > highest_total
        highest_total = total
      end
    end
    @stat_tracker.highest_total_score = highest_total
  end

  def lowest_total_score
    lowest_total = 11
    @game_files.each do |key, value|
      total = value.away_goals + value.home_goals
      if lowest_total > total
        lowest_total = total
      end
    end
    @stat_tracker.lowest_total_score = lowest_total
  end

  def percentage_home_wins
    home_wins = 0
    total_games = 0
    @game_files.each do |key, value|
      if value.home_goals > value.away_goals
        home_wins += 1
        total_games += 1
      elsif value.home_goals <= value.away_goals
        total_games += 1
      end
    end
    percentage_wins = (home_wins.to_f/total_games.to_f).round(2)
    @stat_tracker.percentage_home_wins = percentage_wins
  end

  def percentage_visitor_wins
    visitor_wins = 0
    total_games = 0
    @game_files.each do |key, value|
      if value.away_goals > value.home_goals
        visitor_wins += 1
        total_games += 1
      elsif value.away_goals <= value.home_goals
        total_games += 1
      end
    end
    percentage_wins = (visitor_wins.to_f/total_games.to_f).round(2)
    @stat_tracker.percentage_visitor_wins = percentage_wins
  end
end
