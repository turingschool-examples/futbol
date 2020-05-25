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

 #  def test_it_has_csv_files
 #    assert_equal CSV.read(@game_path, headers: true, header_converters: :symbol), @stat_tracker.games
 #    assert_equal CSV.read(@team_path, headers: true, header_converters: :symbol), @stat_tracker.teams
 #    assert_equal CSV.read(@game_teams_path, headers: true, header_converters: :symbol), @stat_tracker.game_teams
 #  end
 #
 #  def test_it_is_an_instance
 #    assert_instance_of StatTracker, @stat_tracker
 #  end
 #
 #  def test_it_finds_games
 #    game = Game.new(@stat_tracker.games.first)
 #    assert_instance_of Game, game
 #    assert_equal "20122013", game.season
 #    assert_equal "5/16/13", game.date_time
 #    assert_equal "Toyota Stadium", game.venue
 #  end
 #
 #
 #  def test_it_finds_teams
 #    team = Team.new(@stat_tracker.teams.first)
 #    assert_instance_of Team, team
 #    assert_equal "Atlanta United", team.team_name
 #    assert_equal "ATL", team.abbreviation
 #    assert_equal "23", team.franchise_id
 #  end
 #
 #  def test_it_finds_game_teams
 #    game_teams = GameTeams.new(@stat_tracker.game_teams.first)
 #    assert_instance_of GameTeams, game_teams
 #    assert_equal "away", game_teams.hoa
 #    assert_equal "OT", game_teams.settled_in
 #    assert_equal "LOSS", game_teams.result
 #  end
 # ##  start of game statistics
 #
 #  def test_it_highest_total_score
 #    assert_equal 5, @stat_tracker.highest_total_score
 #  end
 #
 #  def test_it_lowest_total_score
 #    assert_equal 1, @stat_tracker.lowest_total_score
 #  end

  def test_it_percentage_home_wins
    assert_equal 68.42, @stat_tracker.percentage_home_wins
  end

  def test_it_percentage_visitor_wins
    assert_equal 26.32, @stat_tracker.percentage_visitor_wins
  end

  def test_it_percentage_ties
    assert_equal 5.26, @stat_tracker.percentage_ties
  end

  # # difference in points for both teams
  # def test_it_can_find_difference_in_total_goals
  #   assert_equal 17, @stat_tracker.lowest_total_score
  # end
end
