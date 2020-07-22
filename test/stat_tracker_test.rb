require "./test/test_helper.rb"
require 'CSV'
require './lib/game_manager'
require './lib/team_manager'
require './lib/game_teams_manager'
require './lib/stat_tracker'
class StatTrackerTest < MiniTest::Test



  def test_goals
    skip
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

  def test_it_can_give_team_info
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    expected = {"team id"=>"18", "franchise_id"=>"34", "team_name"=>"Minnesota United FC", "abbreviation"=>"MIN", "link"=>"/api/v1/teams/18"}

    stats = StatTracker.from_csv(locations)
    assert_equal expected, stats.team_info(18)
  end

  def test_it_can_display_best_season
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal "20132014", stats.best_season(6)

  end

  def test_it_can_display_worst_season
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal "20142015", stats.worst_season(6)
  end

  def test_it_can_display_average_win_percentage
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal 0.49, stats.average_win_percentage(6)
  end

  def test_it_can_display_most_goals_scored
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal "7", stats.most_goals_scored(18)
  end

  def test_it_can_display_fewest_goals_scored
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal "0", stats.fewest_goals_scored(18)
  end

  def test_it_can_display_favorite_opponent
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal "DC United", stats.favorite_opponent(18)
  end

  def test_it_can_display_rival
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal "Houston Dash", stats.rival(18)
  end

end
