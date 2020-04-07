require_relative 'test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      :games => @game_path,
      :teams => @team_path,
      :game_teams => @game_teams_path
                }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_csv_files
    require "pry"; binding.pry
    assert_equal CSV.read(@game_path), @stat_tracker.games
    assert_equal CSV.read(@team_path), @stat_tracker.teams
    assert_equal CSV.read(@game_teams_path), @stat_tracker.game_stats
  end

end
