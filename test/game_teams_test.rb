require "./lib/game_teams"
require "./test/test_helper"

class GameTeamsTest < Minitest::Test
  def test_it_can_read_from_csv
    GameTeams.from_csv

    assert_equal 12, GameTeams.all_game_teams.count
  end

  def test_it_has_attributes
    GameTeams.from_csv

    assert_equal 2014020006, GameTeams.all_game_teams[0].game_id
    assert_equal 1, GameTeams.all_game_teams[0].team_id
    assert_equal "away", GameTeams.all_game_teams[0].hoa
    assert_equal "WIN", GameTeams.all_game_teams[0].result
    assert_equal "REG", GameTeams.all_game_teams[0].settled_in
    assert_equal "Peter DeBoer", GameTeams.all_game_teams[0].head_coach
    assert_equal 4, GameTeams.all_game_teams[0].goals
    assert_equal 6, GameTeams.all_game_teams[0].shots
    assert_equal 36, GameTeams.all_game_teams[0].tackles
    assert_equal 10, GameTeams.all_game_teams[0].pim
    assert_equal 3, GameTeams.all_game_teams[0].ppo
    assert_equal 0, GameTeams.all_game_teams[0].ppg
    assert_equal 42.9, GameTeams.all_game_teams[0].fowp
    assert_equal 4, GameTeams.all_game_teams[0].giveaways
    assert_equal 5, GameTeams.all_game_teams[0].takeaways
  end
end
