require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_team_collection'
require './lib/stat_tracker'
require 'mocha/minitest'

class GameTeamCollectionTest < Minitest::Test
  def setup
    game_path       = './data/games.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path
                }

    @stat_tracker         = StatTracker.from_csv(locations)
    @game_team_collection = GameTeamCollection.new(game_teams_path, @stat_tracker)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameTeamCollection, @game_team_collection
  end
  #FROM THE GAMES STATS SECTION
  def test_compare_hoa_to_result
    assert_equal 3237.0, @game_team_collection.compare_hoa_to_result("home", "WIN")
  end

  def test_total_games
    assert_equal 7441, @game_team_collection.total_games
  end

  def test_it_calls_percentage_of_games_w_home_team_win
    assert_equal 43.5, @game_team_collection.percentage_home_wins
  end

  def test_it_calls_percentage_of_games_w_visitor_team_win
    assert_equal 36.11, @game_team_collection.percentage_visitor_wins
  end

  def test_it_calls_percentage_of_games_tied
    assert_equal 20.39, @game_team_collection.percentage_ties
  end

  def test_total_percentages_equals_100
    assert_equal 100, (@game_team_collection.percentage_home_wins +
                       @game_team_collection.percentage_visitor_wins +
                       @game_team_collection.percentage_ties)
  end

  #LeagueStatistics Methods
  def test_it_can_find_highest_goal
    assert_equal '8', @game_team_collection.find_highest_goal_team_id
  end

  def test_it_can_find_team_name
    assert_equal 'New York Red Bulls', @game_team_collection.best_offense
  end

  def test_it_can_find_lowest_goal
    assert_equal '5', @game_team_collection.find_lowest_goal_team_id
  end

  def test_it_knows_lowest_average_goals_scored_across_season
  # Name of the team with the highest average number of goals scored per game across all seasons.
    assert_equal 'Sporting Kansas City', @game_team_collection.worst_offense
  end
end
