require "./test/test_helper"
require './lib/stat_tracker'
require './lib/game_manager'
require './lib/game_teams_manager'
require './lib/team_manager'
require 'pry';

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/dummy_game.csv'
    team_path = './data/dummy_teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_find_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_it_can_find_the_lowest_total_score
    assert_equal 3, @stat_tracker.lowest_total_score
  end

  def test_it_can_find_percentage_home_wins
    assert_equal 0.38, @stat_tracker.percentage_home_wins
  end

  def test_it_can_find_percentage_visitor_wins
    assert_equal 0.50, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_find_percentage_ties
    assert_equal 0.13, @stat_tracker.percentage_ties
  end

  def test_it_can_count_games_by_season
    expected = {
      '20122013' => 7,
      '20152016' => 1
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_find_average_goals_per_game
    assert_equal 4.75, @stat_tracker.average_goals_per_game
  end

  def test_it_can_find_average_goals_by_season
    expected = {
      '20122013' => 4.86,
      '20152016' => 4.0
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_it_can_return_a_count_teams
    assert_equal 3, @stat_tracker.count_of_teams
  end

  def test_it_can_find_a_name
    team_number = '5'
    assert_equal 'Sporting Kansas City', @stat_tracker.find_team_name(team_number)
  end

  def test_average_number_of_goals_scored_by_team
    assert_equal 1.5, @stat_tracker.average_number_of_goals_scored_by_team('3')
  end

  def test_average_number_of_goals_scored_by_team_by_type
    assert_equal 1.67, @stat_tracker.average_number_of_goals_scored_by_team_by_type('3', 'away')
    assert_equal 1.33, @stat_tracker.average_number_of_goals_scored_by_team_by_type('3', 'home')
  end

  def test_find_best_offense
    assert_equal 'FC Dallas', @stat_tracker.best_offense
  end

  def test_find_worst_offense
    assert_equal 'Sporting Kansas City', @stat_tracker.worst_offense
  end

  def test_it_can_find_highest_scoring_visitor
    assert_equal 'Sporting Kansas City', @stat_tracker.highest_scoring_visitor
  end

  def test_it_can_find_lowest_scoring_visitor
    assert_equal 'Houston Dynamo', @stat_tracker.lowest_scoring_visitor
  end

  def test_it_can_find_highest_scoring_home
    assert_equal 'FC Dallas', @stat_tracker.highest_scoring_home_team
  end

  def test_it_can_lowest_scoring_home
    assert_equal 'Sporting Kansas City', @stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_find_season_id
    game_id = '2012030221'
    assert_equal '20122013', @stat_tracker.find_season_id(game_id)
  end

  def test_it_can_find_winningest_coach
    season_id = '20152016'
    assert_equal 'Mike Sullivan', @stat_tracker.winningest_coach(season_id)
  end

  def test_it_can_find_worst_coach
    season_id = '20122013'
    assert_equal 'John Tortorella', @stat_tracker.worst_coach(season_id)
  end

  def test_most_accurate_team
    season_id = '20122013'
    assert_equal 'FC Dallas', @stat_tracker.most_accurate_team(season_id)
  end

  def test_least_accurate_team
    season_id = '20122013'
    assert_equal 'Sporting Kansas City', @stat_tracker.least_accurate_team(season_id)
  end

  def test_most_tackles
    season_id = '20122013'
    assert_equal 'FC Dallas', @stat_tracker.most_tackles(season_id)
  end

  def test_fewest_tackles
    season_id = '20122013'
    assert_equal 'Sporting Kansas City', @stat_tracker.fewest_tackles(season_id)
  end

  def test_it_can_find_team_info
    team_id = '5'
    expected = {
                'team_id' => '5',
                'franchise_id' => '17',
                'team_name' => 'Sporting Kansas City',
                'abbreviation' => 'SKC',
                'link' => '/api/v1/teams/5'
    }
    assert_equal expected, @stat_tracker.team_info(team_id)
  end

  def test_it_can_find_best_season
    team_id = '3'
    assert_equal '20122013', @stat_tracker.best_season(team_id)
  end

  def test_it_can_find_worst_season
    team_id = '3'
    assert_equal '20122013', @stat_tracker.worst_season(team_id)
  end

  def test_average_win_percentage
    team_id = '3'
    assert_equal 0.0, @stat_tracker.average_win_percentage(team_id)
  end

  def test_it_can_get_most_goals_scored_for_team
    team_id = '6'
    assert_equal 4, @stat_tracker.most_goals_scored(team_id)
  end

  def test_it_can_get_fewest_goals_scored_for_team
    team_id = '6'
    assert_equal 1, @stat_tracker.fewest_goals_scored(team_id)
  end

  def test_team_favorite_opponent
    team_id = '6'
    assert_equal 'Houston Dynamo', @stat_tracker.favorite_opponent(team_id)
  end

  def test_team_rival
    team_id = '6'
    assert_equal 'Houston Dynamo', @stat_tracker.rival(team_id)
  end
end
