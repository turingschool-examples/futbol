require 'csv'
require_relative 'test_helper'
require './lib/game_teams'

class GameTeamsTest < MiniTest::Test
  def setup
    @game_teams = GameTeams.new({game_id: "2012030223",
                                team_id: "6",
                                hoa: "away",
                                result: "WIN",
                                settled_in: "REG",
                                head_coach: "Claude Julien",
                                goals: "2",
                                shots: "8",
                                tackles: "28",
                                pim: "6",
                                powerplayopportunities: "0",
                                powerplaygoals: "0",
                                faceoffwinpercentage: "61.8",
                                giveaways: "10",
                                takeaways: "7"
      })
  end

  def test_it_exists
    assert_instance_of GameTeams, @game_teams
  end

  def test_it_has_attributes
    assert_equal "Claude Julien", @game_teams.head_coach
    assert_equal "2", @game_teams.goals
    assert_equal "0", @game_teams.power_play_goals
  end

  def test_it_finds_team_info
    expected = {"team_id"=>"8",
                "franchise_id"=>"1",
                "team_name"=>"New York Red Bulls",
                "abbreviation"=>"NY",
                "stadium"=>"Red Bull Arena",
                "link"=>"/api/v1/teams/8"
              }
    assert_equal expected, @stat_tracker.team_info(8)
  end

  def test_it_finds_games_played_that_season
    expected = {
                "2012"=>53.0,
                "2014"=>94.0,
                "2013"=>99.0,
                "2016"=>88.0,
                "2017"=>82.0,
                "2015"=>82.0}
    assert_equal expected, @stat_tracker.find_number_of_games_played_in_a_season(8)
  end

  def test_it_finds_best_season
    assert_equal "20162017", @stat_tracker.best_season(8)
  end

  def test_it_finds_worst_season
    assert_equal "20142015", @stat_tracker.worst_season(8)
  end

  def test_it_finds_average_win_percentage
    assert_equal 41.77, @stat_tracker.average_win_percentage(8)
  end

  def test_it_finds_most_goals_scored
    assert_equal 8, @stat_tracker.most_goals_scored(8)
  end

  def test_it_finds_least_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored(8)
  end

  def test_it_finds_favorite_opponent
    assert_equal "New England Revolution", @stat_tracker.favorite_opponent(8)
  end

  def test_it_finds_rival
    assert_equal "New England Revolution", @stat_tracker.rival(18)
  end
end
