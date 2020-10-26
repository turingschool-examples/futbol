require_relative './test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stattracker = StatTracker.from_csv(locations)
  end

  def test_it_exists_and_has_attributes

    assert_instance_of StatTracker, @stattracker
  end

  def test_highest_total_score

    assert_equal 5, @stattracker.highest_total_score
  end

  def test_lowest_total_score

    assert_equal 1, @stattracker.lowest_total_score
  end

  def test_percentage_home_wins

    assert_equal 53.85, @stattracker.percentage_home_wins
  end

  def test_percentage_visitor_wins

    assert_equal 38.46, @stattracker.percentage_visitor_wins
  end
#
#   def percentage_ties
#   end
#
#   def count_of_games_by_season
#   end
#
#   def average_goals_per_game
#   end
#
#   def average_goals_by_season
#   end
#
#   def count_of_teams
#   end
#
#   def best_offense
#   end
#
#   def worst_offense
#   end
#
#   def highest_scoring_visitor
#   end
#
#   def highest_scoring_home_team
#   end
#
#   def lowest_scoring_visitor
#   end
#
#   def lowest_scoring_home_team
#   end
#
#   def team_info
#   end
#
#   def best_season
#   end
#
#   def worst_season
#   end
#
#   def average_win_percentage
#   end
#
#   def most_goals_scored
#   end
#
#   def fewest_goals_scored
#   end
#
#   def favorite_opponent
#   end
#
#   def rival
#   end
#
#   def winningest_coach
#   end
#
#   def worst_coach
#   end
#
#   def most_accurate_team
#   end
#
#   def least_accurate_team
#   end
#
#   def most_tackles
#   end
#
#   def fewest_tackles
#   end
#
end
