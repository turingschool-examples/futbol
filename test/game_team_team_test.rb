require './test/test_helper'

class GameTeamTeamTest < Minitest::Test
  def setup
    game_path       = './data/games_dummy.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path,
                }

    @stat_tracker         = StatTracker.from_csv(locations)
    @game_team_team       = GameTeamTeam.new(game_teams_path, @stat_tracker)
  end

  def test_it_can_find_total_games_per_team_id
    assert_equal 27, @game_team_team.total_games('3').count
  end

  def test_it_can_find_winning_games
    assert_equal 10, @game_team_team.winning_games('3').count
  end

  def test_it_can_find_average_win_percentage
    assert_equal 37.04, @game_team_team.average_win_percentage('3')
  end

  def test_it_can_find_team_id_for_lowest_win_percentage
    assert_equal '15', @game_team_team.lowest_win_percentage('3')
  end

  def test_it_can_find_winning_games_per_team_id
    assert_equal 10, @game_team_team.winning_games('3').count
  end

  def test_it_can_list_number_of_games_lost_per_opposing_team
    expected = {"15"=>2, "5"=>5, "14"=>3}
    assert_equal expected, @game_team_team.lowest_opposing_team('3')
  end

  def test_it_can_list_total_games_played_with_opposing_team
    expected = {
                "15"=>["15", "15"],
                "5"=>["5", "5", "5", "5", "5"],
                "14"=>["14", "14", "14"]
              }
    assert_equal expected, @game_team_team.total_opposing_team_games('3')
  end

  def test_it_can_find_losing_games_per_team_id
    assert_equal 17, @game_team_team.losing_games('3').count
  end

  def test_it_can_find_team_id_for_highest_win_percentage
    assert_equal '15', @game_team_team.highest_win_percentage('3')
  end

  def test_it_can_list_number_of_games_won_per_opposing_team
    expected = {"6"=>5, "15"=>5, "5"=>4, "14"=>3}
    assert_equal expected, @game_team_team.highest_opposing_team('3')
  end

  def test_it_can_find_highest_goals_by_team
    assert_equal 5, @game_team_team.most_goals_scored('3')
  end

  def test_it_can_find_fewest_goals_by_team
    assert_equal 0, @game_team_team.fewest_goals_scored('3')
  end

end
