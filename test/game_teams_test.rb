require_relative '../test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams'
require './lib/team'

class GameTeamsTest < Minitest::Test

  def setup
    @game_teams = GameTeams.from_csv("./test/fixtures/game_teams.csv")
    @first_game_team = GameTeams.all[0]
    Team.from_csv("./test/fixtures/teams.csv")
    @teams = Team.all
  end

  def test_it_exists
    assert_instance_of GameTeams, @first_game_team
  end

  def test_it_can_get_the_highest_winning_team
    assert_equal 'FC Dallas', GameTeams.winningest_team
  end

  def test_it_can_get_the_best_fans
    assert_equal 'FC Dallas', GameTeams.best_fans
  end

  def test_it_can_get_the_worst_fans
    assert_equal ['Houston Dynamo'], GameTeams.worst_fans
  end

  def test_it_can_group_games_into_teams
    game_team_id3 = [@game_teams[0], @game_teams[2], @game_teams[5], @game_teams[7], @game_teams[8]]
    game_team_id6 = [@game_teams[1], @game_teams[3], @game_teams[4], @game_teams[6], @game_teams[9], @game_teams[10]]
    assert_equal game_team_id3, GameTeams.games_per_team["3"]
    assert_equal game_team_id6, GameTeams.games_per_team["6"]
  end


  def test_it_can_return_home_away_games_per_team
    expected_output = {"3" => {
            "away" => [@game_teams[0], @game_teams[2], @game_teams[8]],
            "home" => [@game_teams[5], @game_teams[7]]
            },
      "6"=> {
            "away" => [@game_teams[4], @game_teams[6], @game_teams[10]],
            "home" => [@game_teams[1], @game_teams[3], @game_teams[9]]
            }}
    assert_equal true, (expected_output == GameTeams.home_away_games_per_team)
  end

  def test_it_can_return_win_loss_perc_per_team
    expected_output = {
      "3"=>{:away_win_percentage=>0.3333, :home_win_percentage=>0.0},
      "6"=>{:away_win_percentage=>0.6667, :home_win_percentage=>1.0}
    }
    assert_equal true, (expected_output == GameTeams.win_loss_perc_per_team)
  end

  def test_it_can_return_difference_home_and_away_wins_percentage
    expected_output = {"3" => 0.0, "6" => 0.3333}
    assert_equal true, (expected_output == GameTeams.difference_home_and_away_wins_percentage)
  end

  def test_all_away_games_by_team
    expected = {
      "3" => [@game_teams[0], @game_teams[2], @game_teams[8]],
      "6" => [@game_teams[4], @game_teams[6], @game_teams[10]]
    }
    assert_equal expected, GameTeams.away_games
  end

  def test_all_home_games_by_team
    expected = {
        "3" => [@game_teams[5], @game_teams[7]],
        "6" => [@game_teams[1], @game_teams[3], @game_teams[9]]
    }
    assert_equal expected, GameTeams.home_games
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", GameTeams.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "FC Dallas", GameTeams.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Houston Dynamo", GameTeams.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Houston Dynamo", GameTeams.lowest_scoring_home_team
  end

end
