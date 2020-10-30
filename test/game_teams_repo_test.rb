require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'mocha/minitest'
require './lib/game_teams_repo'

class GameTeamsRepoTest < Minitest::Test
  def setup
    game_teams_path = './data/game_teams.csv'

    locations = {
      game_teams: game_teams_path
    }
    @parent = mock()
    @game_teams_repo = GameTeamsRepo.new(locations[:game_teams_path], @parent)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Array, @game_teams_repo.game_teams
    assert mock(), @parent
  end

  def test_create_game_teams
    assert_instance_of GameTeams, @game_teams_repo.game_teams[0]
  end

  def test_find_team_by
    assert_instance_of Array, @game_teams_repo.find_team_by(6)
  end

  def test_find_average_goals_by_id
    assert_equal 2.26, @game_teams_repo.average_goals_by(6)
  end

  def test_team_ids
    assert_instance_of Array, @game_teams_repo.team_ids
  end

  def test_highest_and_lowest_scoring_team_across_all_seasons
    assert_equal 54, @game_teams_repo.highest_average_goals
    assert_equal 7, @game_teams_repo.lowest_average_goals
  end

  def test_games_containing
    assert_equal 2, @game_teams_repo.games_containing(:game_id, "2012030221").length
  end 

  def test_percentage_wins
    assert_equal 0.44, @game_teams_repo.percentage_wins("home")
    assert_equal 0.36, @game_teams_repo.percentage_wins("away")
  end

  def test_percentage_ties
    assert_equal 0.20, @game_teams_repo.percentage_ties
  end
end
