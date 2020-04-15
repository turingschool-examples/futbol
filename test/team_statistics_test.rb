require './test/test_helper'
require './lib/stat_tracker'
require './lib/team_statistics'
require './lib/keyable'
require 'mocha/minitest'
require 'pry'

class TeamStatisticsTest < Minitest::Test

  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_fixture.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @team_statistics = @stat_tracker.team_statistics
  end

  def test_it_exists
    assert_instance_of TeamStatistics, @team_statistics
  end

  def test_it_has_readable_attributes
    assert_instance_of Array, @team_statistics.game_collection
    assert_instance_of Array, @team_statistics.game_teams_collection
    assert_instance_of Array, @team_statistics.teams_collection

    assert_equal "2012030221", @team_statistics.game_collection[0].game_id
    assert_equal "2014030326", @team_statistics.game_collection[-1].game_id

    assert_equal "2012030221", @team_statistics.game_teams_collection[0].game_id
    assert_equal "2012030124", @team_statistics.game_teams_collection[-1].game_id

    assert_equal "1", @team_statistics.teams_collection[0].id
    assert_equal "53", @team_statistics.teams_collection[-1].id
  end

  def test_team_info
    expected1 = {"team_id" => "1", "franchise_id" => "23", "team_name" => "Atlanta United", "abbreviation" => "ATL", "link" => "/api/v1/teams/1"}
    expected2 = {"team_id" => "4", "franchise_id" => "16", "team_name" => "Chicago Fire", "abbreviation" => "CHI", "link"=> "/api/v1/teams/4"}

    assert_equal expected1, @team_statistics.team_info("1")
    assert_equal expected2, @team_statistics.team_info("4")
  end

  def test_games_played
    assert_instance_of Array, @team_statistics.games_played("3")
    games_played = @team_statistics.games_played("3")
    assert_equal "2012030221", games_played[0].game_id
    assert_equal "2012030225", games_played[-1].game_id
  end

  def test_season_best_and_worst
    assert_equal "20132014", @team_statistics.season_best_and_worst("24", "high")
    assert_equal "20142015", @team_statistics.season_best_and_worst("24", "low")
  end

  def test_average_win_percentage
    assert_equal 0.0, @team_statistics.average_win_percentage("3")
    assert_equal 1.0, @team_statistics.average_win_percentage("6")
    assert_equal 0.5, @team_statistics.average_win_percentage("9")
    assert_equal 0.25, @team_statistics.average_win_percentage("8")
  end

  def test_goals_scored_high_and_low
    assert_equal 3, @team_statistics.goals_scored_high_and_low("6", "high")
    assert_equal 2, @team_statistics.goals_scored_high_and_low("3", "high")
    assert_equal 3, @team_statistics.goals_scored_high_and_low("8", "high")
    assert_equal 4, @team_statistics.goals_scored_high_and_low("9", "high")
    assert_equal 2, @team_statistics.goals_scored_high_and_low("6", "low")
    assert_equal 1, @team_statistics.goals_scored_high_and_low("3", "low")
    assert_equal 1, @team_statistics.goals_scored_high_and_low("8", "low")
    assert_equal 1, @team_statistics.goals_scored_high_and_low("9", "low")
  end

  def test_games_by_opponent_team_id
    assert_equal "2012030221", @team_statistics.games_by_opponent_team_id("3")["6"][0].game_id
    assert_equal "2012030225", @team_statistics.games_by_opponent_team_id("3")["6"][-1].game_id
    assert_equal "2013020177", @team_statistics.games_by_opponent_team_id("24")["4"][0].game_id
    assert_equal "2014030322", @team_statistics.games_by_opponent_team_id("24")["16"][0].game_id
    assert_equal "2014030326", @team_statistics.games_by_opponent_team_id("24")["16"][-1].game_id
  end

  def test_count_wins
    games_played = @team_statistics.game_collection[0..4]
    assert_equal 0, @team_statistics.count_wins("3", games_played)
    assert_equal 5, @team_statistics.count_wins("6", games_played)
  end

  def test_games_won_by_opponent
    expected = {"6"=>[0, 5]}
    assert_equal expected, @team_statistics.games_won_by_opponent("3")

    expected = {"4"=>[1, 1], "29"=>[1, 1], "22"=>[0, 1], "8"=>[1, 1], "16"=>[2, 5]}
    assert_equal expected, @team_statistics.games_won_by_opponent("24")

    expected = {"3"=>[5, 5], "5"=>[4, 4], "12"=>[1, 1]}
    assert_equal expected, @team_statistics.games_won_by_opponent("6")
  end

  def test_win_percentage_against_opponent
    expected = {"6"=>0.0}
    assert_equal expected, @team_statistics.win_percentage_against_opponent("3")

    expected = {"3"=>1.0, "5"=>1.0, "12"=>1.0}
    assert_equal expected, @team_statistics.win_percentage_against_opponent("6")

    expected = {"4"=>1.0, "29"=>1.0, "22"=>0.0, "8"=>1.0, "16"=>0.4}
    @team_statistics.win_percentage_against_opponent("24")
  end

  def test_opponent_preference
    assert_equal "Chicago Fire", @team_statistics.opponent_preference("24", "fav")
    assert_equal "FC Dallas", @team_statistics.opponent_preference("3", "rival")
    assert_equal "Philadelphia Union", @team_statistics.opponent_preference("22", "fav")
    assert_equal "Real Salt Lake", @team_statistics.opponent_preference("22", "rival")
  end

  def test_high_low_key_return
    win_percentages = {
      "3" => 0.5,
      "4" => 0.75,
      "5" => 0.2
    }
    assert_equal "4", @team_statistics.high_low_key_return(win_percentages, "high")
    assert_equal "5", @team_statistics.high_low_key_return(win_percentages, "low")
  end
end
