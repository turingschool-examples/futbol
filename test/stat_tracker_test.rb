require 'csv'
require_relative 'test_helper'
require './lib/stat_tracker'
require './lib/game'

class StatTrackerTest < MiniTest::Test

  def setup
    @game_path = "./data/games_truncated.csv"
    @team_path = "./data/teams.csv"
    @game_teams_path = "./data/game_teams.csv"
    @locations = {
                  games: @game_path,
                  teams: @team_path,
                  game_teams: @game_teams_path
                  }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_has_csv_files
    skip
    assert_instance_of Array, @stat_tracker.games
    assert_instance_of Game, @stat_tracker.games[0]
    assert_instance_of Array, @stat_tracker.teams
    assert_instance_of Team, @stat_tracker.teams[0]
    assert_equal CSV.read(@game_teams_path, headers: true, header_converters: :symbol), @stat_tracker.game_teams
  end

  def test_it_is_an_instance
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_finds_games
    skip
    game = Game.new(@stat_tracker.games.first)
    assert_instance_of Game, game
    assert_equal "20122013", game.season
    assert_equal "5/16/13", game.date_time
    assert_equal "Toyota Stadium", game.venue
  end

  def test_it_finds_teams
    skip
    team = Team.new(@stat_tracker.teams.first)
    assert_instance_of Team, team
    assert_equal "Atlanta United", team.team_name
    assert_equal "ATL", team.abbreviation
    assert_equal "23", team.franchise_id
  end

  def test_it_finds_game_teams
    skip
    game_teams = GameTeams.new(@stat_tracker.game_teams.first)
    assert_instance_of GameTeams, game_teams
    assert_equal "away", game_teams.hoa
    assert_equal "OT", game_teams.settled_in
    assert_equal "LOSS", game_teams.result
  end
 #  start of game statistics

  def test_it_has_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_it_has_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_has_percentage_home_wins
    assert_equal 55.56, @stat_tracker.percentage_home_wins
  end

  def test_it_has_percentage_visitor_wins
    assert_equal 38.89, @stat_tracker.percentage_visitor_wins
  end

  def test_it_has_percentage_ties
    assert_equal 5.56, @stat_tracker.percentage_ties
  end

  def test_it_finds_count_of_games_by_season
    @stat_tracker.expects(:count_of_games_by_season).returns({"20122013"=>3, "20142015"=>4})
    assert_equal ({"20122013"=>3, "20142015"=>4}), @stat_tracker.count_of_games_by_season
  end

  def test_it_can_find_average_goals_per_game
    assert_equal 1.96, @stat_tracker.average_goals_per_game
  end

  def test_has_average_goals_by_season
    @stat_tracker.expects(:average_goals_by_season).returns({"20122013"=>3, "20142015"=>4})
    assert_equal ({"20122013"=>3, "20142015"=>4}), @stat_tracker.average_goals_by_season
  end

  def test_it_counts_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_finds_best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  def test_it_finds_worst_offense
      assert_equal "Los Angeles FC", @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "New York City FC", @stat_tracker.highest_scoring_home_team
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
