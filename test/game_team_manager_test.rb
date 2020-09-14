require './test/test_helper'
require './lib/game_team_manager'
require 'pry'

class GameTeamManagerTest < Minitest::Test
  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './fixtures/fixture_game_teams.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = mock('stat tracker')
    @game_team_manager = GameTeamManager.new(@locations, @stat_tracker)
  end

  def test_it_exists

    assert_instance_of GameTeamManager, @game_team_manager
  end

  def test_can_get_game_team_info

    assert_equal 80, @game_team_manager.game_teams.count
  end

  # def test_game_teams_data_for_season
  #
  #   assert_equal 1612, @game_team_manager.game_teams_data_for_season('20122013').length
  #   assert_equal '2012030221', @game_team_manager.game_teams_data_for_season('20122013')[0].game_id
  #   assert_equal 'Todd McLellan', @game_team_manager.game_teams_data_for_season('20122013')[-1].head_coach
  # end
  #
  # def test_season_coaches
  #   expected_1 = ['John Tortorella', 'Claude Julien', 'Dan Bylsma']
  #   expected_2 = ['Jon Cooper', 'Martin Raymond', 'Dan Lacroix']
  #
  #   assert_equal 34, @game_team_manager.season_coaches('20122013').length
  #   assert_equal expected_1, @game_team_manager.season_coaches('20122013')[0..2]
  #   assert_equal expected_2, @game_team_manager.season_coaches('20122013')[-3..-1]
  # end
  #
  # def test_winningest_coach
  #
  #   assert_equal 'Claude Julien', @game_team_manager.winningest_coach('20132014')
  # end
  #
  # def test_worst_coach
  #
  #   assert_equal 'Peter Laviolette', @game_team_manager.worst_coach('20132014')
  # end
  #
  # def test_coaches_by_win_percentage
  #
  #   assert_equal 34, @game_team_manager.coaches_by_win_percentage('20132014').length
  #   assert_equal 48.42, @game_team_manager.coaches_by_win_percentage('20132014')['Dan Bylsma']
  # end
  #
  # def test_total_shots_by_team
  #
  #   assert_equal 779, @game_team_manager.total_shots_by_team('20132014', '16')
  #   assert_equal 571, @game_team_manager.total_shots_by_team('20132014', '15')
  # end
  #
  # def test_total_goals_by_team
  #
  #   assert_equal 237, @game_team_manager.total_goals_by_team('20132014', '16')
  #   assert_equal 161, @game_team_manager.total_goals_by_team('20132014', '15')
  # end
  #
  # def test_season_teams
  #   expected = ['16', '19', '30', '21', '26', '24', '25', '23',
  #               '4', '17', '29', '15', '20', '18', '6', '8', '5', '2', '52',
  #               '14', '13', '28', '7', '10', '27', '1', '9', '22', '3', '12']
  #   assert_equal 30, @game_team_manager.season_teams('20132014').length
  #   assert_equal expected, @game_team_manager.season_teams('20132014')
  # end
  #
  # def test_team_accuracy
  #
  #   assert_equal 0.270073, @game_team_manager.team_accuracy("20132014")['3']
  #   assert_equal 0.334776, @game_team_manager.team_accuracy("20132014")['24']
  # end
  #
  # def test_most_accurate_team
  #
  #   assert_equal 'Real Salt Lake', @game_team_manager.most_accurate_team('20132014')
  # end
  #
  # def test_least_accurate_team
  #
  #   assert_equal 'New York City FC', @game_team_manager.least_accurate_team('20132014')
  # end
  #
  # def test_most_tackles
  #
  #   assert_equal 'FC Cincinnati', @game_team_manager.most_tackles('20132014')
  # end
  #
  # def test_fewest_tackles
  #
  #   assert_equal 'Atlanta United', @game_team_manager.fewest_tackles('20132014')
  # end
  #
  # def test_team_by_id
  #
  #   assert_equal [], @game_team_manager.team_by_id("16")
  # end
end
