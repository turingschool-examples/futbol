require './test/test_helper'

class GameTeamLeagueTest < Minitest::Test
  def setup
    game_path       = './data/games_dummy.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path,
                }

    @stat_tracker         = StatTracker.from_csv(locations)
    @game_team_league     = GameTeamLeague.new(game_teams_path, @stat_tracker)
  end


  def test_it_can_find_team_name
    assert_equal 'Houston Dynamo', @game_team_league.best_offense
  end

  def test_it_knows_lowest_average_goals_scored_across_season
    assert_equal 'Sporting Kansas City', @game_team_league.worst_offense
  end

  def test_it_knows_highest_scoring_away
    assert_equal 'FC Dallas', @game_team_league.highest_scoring_visitor
  end

  def test_it_knows_highest_average_home
    assert_equal 'New York City FC', @game_team_league.highest_scoring_home_team
  end

  def test_it_knows_lowest_average_away
    assert_equal 'Seattle Sounders FC', @game_team_league.lowest_scoring_visitor
  end

  def test_it_knows_lowest_average_home
    assert_equal 'Orlando City SC', @game_team_league.lowest_scoring_home_team
  end

  def test_it_can_find_highest_goal
    assert_equal '3', @game_team_league.find_highest_goal_team_id
  end

  def test_it_can_find_lowest_goal
    assert_equal '5', @game_team_league.find_lowest_goal_team_id
  end

  def test_it_can_find_highest_average_team_id_visitor
    assert_equal '6', @game_team_league.highest_average_team_id_visitor
  end

  def test_it_can_find_highest_average_team_id_home
    assert_equal '9', @game_team_league.highest_average_team_id_home
  end

  def test_it_can_find_lowest_average_team_id_visitor
    assert_equal '2', @game_team_league.lowest_average_team_id_visitor
  end

  def test_it_can_find_lowest_average_team_id_home
    assert_equal '30', @game_team_league.lowest_average_team_id_home
  end

end
