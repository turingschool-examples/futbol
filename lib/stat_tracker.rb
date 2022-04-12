require 'pry'
require 'csv'

class StatTracker

  def initialize(stats)
    @stats = stats
  end

  def self.from_csv(locations)
    info = []
    locations.each do |key, path|
      info << CSV.read(path, headers: true, header_converters: :symbol)
    end
    StatTracker.new(info)
  end

  def highest_total_score
    total = 0
    @stats[0].each do |row|
      if total < row[:home_goals].to_i + row[:away_goals].to_i
        total = row[:home_goals].to_i + row[:away_goals].to_i
      end
    end
    return total
  end

  def lowest_total_score
  end

  def percentage_home_wins
  end

  def percentage_visitor_wins
  end

  def percentage_ties
  end

  def count_of_games_by_season
  end

  def average_goals_per_game
  end

  def average_goals_by_season
  end

  # -----league statistics-------

  def count_of_teams
  end

  def best_offense
  end

  def worst_offense
  end

  def highest_scoring_visitor
  end

  def highest_scoring_home_team
  end

  def lowest_scoring_visitor
  end

  def lowest_scoring_home_team
  end

  # -----season statistics-------

  def winningest_coach
  end

  def worst_coach
  end

  def most_accurate_team
  end

  def least_accurate_team
  end

  def most_tackles
  end

  def fewest_tackles
  end

  # -----team statistics-------

  def team_info
  end

  def best_season
  end

  def worst_season
  end

  def average_win_percentage
  end

  def most_goals_scored
  end

  def fewest_goals_scored
  end

  def favorite_opponent
  end

  def rival
  end
end
