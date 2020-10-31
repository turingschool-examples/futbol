require_relative './test_helper'

class GameTeamsManagerTest < Minitest::Test
  def setup
    locations = {
      games: './data/fixture_files/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/fixture_files/game_teams.csv'
    }
    controller = StatTracker.from_csv(locations)
    @game_teams_manager = controller.game_teams_manager
  end

  def test_it_exists	
    assert_instance_of GameTeamsManager, @game_teams_manager
  end

  def test_winningest_coach
    assert_equal "Dan Bylsma", @game_teams_manager.winningest_coach(20152016)
  end

  def test_coaches
    coach_hash = {:games => 0, :wins => 0}

    all_coaches = @game_teams_manager.coaches_by_season(20152016)

    assert_equal coach_hash, all_coaches["Jack Capuano"]
  end

  def test_verify_in_season
    assert @game_teams_manager.verify_in_season(20152016, 2015030143)
    assert_equal false, @game_teams_manager.verify_in_season(20152016, 2013020293)
  end
end