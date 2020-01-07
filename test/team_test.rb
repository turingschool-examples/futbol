require_relative 'test_helper'
require 'mocha/minitest'
require_relative '../lib/team'
require_relative '../lib/stat_tracker'
require 'pry'

class TeamTest < MiniTest::Test
  def setup
    locations = game_path = './test/fixtures/truncated_games.csv'
		team_path = './test/fixtures/truncated_teams.csv'
		game_teams_path = './test/fixtures/truncated_game_teams.csv'
		locations = {
		  games: game_path,
		  teams: team_path,
		  game_teams: game_teams_path
		}

    @stat_tracker = StatTracker.new(locations)
    @team = Team.new({team_id: "3",
                      franchiseid: 10,
                      teamname: "Houston Dynamo",
                      abbreviation: "HOU",
                      stadium: "BBVA Stadium",
                      link: "/api/v1/teams/3"})

    game1 = mock("Game1")
    game1.stubs(:away_goals => 2,
                :winner => 1,
                :home_goals => 1,
                :home_team_id => 2,
                :away_team_id => 3)
    game2 = mock("Game2")
    game2.stubs(:away_goals => 1,
                :winner => 3,
                :home_goals => 2,
                :home_team_id => 2,
                :away_team_id => 3)
    game3 = mock("Game3")
    game3.stubs(:home_goals => 4,
                :winner => 1,
                :away_goals => 1,
                :home_team_id => 3,
                :away_team_id => 2)
    game4 = mock("Game4")
    game4.stubs(:home_goals => 3,
                :winner => 3,
                :away_goals => 2,
                :home_team_id => 3,
                :away_team_id => 2)



    fake_away_games = [game1, game2]
    fake_home_games = [game3, game4]

    @team.stubs(:away_games => fake_away_games, :home_games => fake_home_games)
  end

  def teardown
    Game.reset_all
  end

  def test_team_is_made_with_accessible_states
    assert_instance_of Team, @team
    assert_equal 3, @team.team_id
    assert_equal 10, @team.franchise_id
    assert_equal "Houston Dynamo", @team.team_name
    assert_equal "HOU", @team.abbreviation
    assert_equal "BBVA Stadium", @team.stadium
    assert_equal "/api/v1/teams/3", @team.link
  end

  def test_can_pull_stats_by_season
    expected = {:win_percentage=>0.0, :total_goals_scored=>8.0, :total_goals_against=>14.0, :average_goals_scored=>1.6, :average_goals_against=>2.8}
    assert_equal expected, @team.stats_by_season["20122013"][:postseason]
  end

  def test_has_hash_of_info
    expected = {"team_id" => "3",
                "franchise_id" => "10",
                "team_name" => "Houston Dynamo",
                "abbreviation" => "HOU",
                "link" => "/api/v1/teams/3"}

    assert_equal expected, @team.team_info
  end

  def test_that_teams_have_average_away_scores
    assert_equal 1.5, @team.average_goals_away
  end

  def test_that_home_teams_have_average_home_scores
    assert_equal 3.5, @team.average_goals_home
  end

  def test_can_find_average_goals_total
    assert_equal 2.5, @team.average_goals_total
  end

  def test_can_return_total_games_played
    assert_equal 4, @team.total_games_played
  end

  def test_can_find_win_percent_total
    assert_equal 0.5, @team.win_percent_total
  end

  def test_can_find_home_only_win_percentage
    assert_equal 0.5, @team.home_win_percentage
  end

  def test_can_find_away_only_win_percentage
    assert_equal 0.5, @team.away_win_percentage
  end

  def test_can_find_total_scores_against
    assert_equal 1.5, @team.total_scores_against
  end

  def test_can_return_total_winning_percentage
    assert_equal 0.5, @team.total_winning_percentage
  end

  def test_can_return_home_win_percentage
    assert_equal 0.5, @team.home_win_percentage
  end

  def test_can_return_away_win_percentage
    assert_equal 0.5, @team.away_win_percentage
  end
end
