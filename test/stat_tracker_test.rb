require 'csv'
require_relative 'test_helper'
require './lib/stat_tracker'

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
    assert_equal CSV.read(@game_path, headers: true, header_converters: :symbol, converters: :numeric), @stat_tracker.games
    assert_equal CSV.read(@team_path, headers: true, header_converters: :symbol, converters: :numeric), @stat_tracker.teams
    assert_equal CSV.read(@game_teams_path, headers: true, header_converters: :symbol, converters: :numeric), @stat_tracker.game_teams
  end

  def test_it_is_an_instance
    assert_instance_of StatTracker, @stat_tracker
  end
  # more robust testing options
  # def test_it_finds_games
  #   games = @stat_tracker.games.first
  #   assert_instance_of Game, games
  #   assert_equal '20122013', games.season
  # end

  # start of game stat methods
  # total score for both teams
  def test_it_can_find_total_goals_for_both_teams
    skip
    assert_equal 70, @stat_tracker.highest_total_score
  end
  # difference in points for both teams
  # def test_it_can_find_difference_in_total_goals
  #   assert_equal 17, @stat_tracker.lowest_total_score
  # end
end
