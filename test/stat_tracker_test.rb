require "./test/test_helper.rb"
require 'CSV'
require './lib/game_manager'
require './lib/team_manager'
require './lib/game_teams_manager'
require './lib/stat_tracker'
class StatTrackerTest < MiniTest::Test



  def test_goals
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    assert_equal 5, stat_tracker.highest_total_score
  end


  # def test_it_has_attributes
  #   game_path = './data/games.csv'
  #   team_path = './data/teams.csv'
  #   game_teams_path = './data/game_teams.csv'
  #
  #   locations = {
  #     games: game_path,
  #     teams: team_path,
  #     game_teams: game_teams_path
  #   }
  #
  #   stat_tracker = StatTracker.from_csv(locations)
  #   assert_equal './data/games.csv', stat_tracker.games_data
  #   assert_equal './data/game_teams.csv', stat_tracker.game_teams_data
  #   assert_equal './data/teams.csv', stat_tracker.teams_data
  #   assert_equal Hash, stat_tracker.games.class
  #   assert_equal Hash, stat_tracker.game_stats.class
  #   assert_equal Hash, stat_tracker.teams.class
  #
  # end
  #
  # def test_it_can_generate_games
  #   game_path = './data/games.csv'
  #   team_path = './data/teams.csv'
  #   game_teams_path = './data/game_teams.csv'
  #
  #   locations = {
  #     games: game_path,
  #     teams: team_path,
  #     game_teams: game_teams_path
  #   }
  #
  #   stat_tracker = StatTracker.from_csv(locations)
  #   stat_tracker.generate_games
  #   assert_equal 7441, stat_tracker.games.count
  # end
  #
  # def test_it_can_generate_teams
  #   game_path = './data/games.csv'
  #   team_path = './data/teams.csv'
  #   game_teams_path = './data/game_teams.csv'
  #
  #   locations = {
  #     games: game_path,
  #     teams: team_path,
  #     game_teams: game_teams_path
  #   }
  #
  #   stat_tracker = StatTracker.from_csv(locations)
  #   stat_tracker.generate_teams
  #   assert_equal 32, stat_tracker.teams.count
  # end
  #
  # def test_it_can_generate_game_stats
  #   game_path = './data/games.csv'
  #   team_path = './data/teams.csv'
  #   game_teams_path = './data/game_teams.csv'
  #
  #   locations = {
  #     games: game_path,
  #     teams: team_path,
  #     game_teams: game_teams_path
  #   }
  #
  #   stat_tracker = StatTracker.from_csv(locations)
  #   stat_tracker.generate_game_stats
  #   require "pry"; binding.pry
  #   assert_equal 7441, stat_tracker.game_stats.count
  # end

end
