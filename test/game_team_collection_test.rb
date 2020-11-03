require './test/test_helper'

class GameTeamCollectionTest < Minitest::Test
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
    @game_team_collection = GameTeamCollection.new(game_teams_path, @stat_tracker)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameTeamCollection, @game_team_collection
  end




  # Team Statisitcs
  def test_it_can_find_total_games_per_team_id
    assert_equal 434, @game_team_collection.total_games('3').count
  end

  def test_it_can_find_winning_games
    assert_equal 230, @game_team_collection.winning_games('3').count
  end

  def test_it_can_find_average_win_percentage
    assert_equal 53.0, @game_team_collection.average_win_percentage('3')
  end

  def test_it_can_find_team_id_for_lowest_win_percentage
    assert_equal '15', @game_team_collection.lowest_win_percentage('3')
  end

  def test_it_can_find_winning_games_per_team_id
    assert_equal 230, @game_team_collection.winning_games('3').count
  end

  def test_it_can_list_number_of_games_lost_per_opposing_team
    expected = {
                "15"=>14, "5"=>16, "14"=>12, "1"=>11, "9"=>8, "4"=>15,
                "18"=>3, "16"=>5, "8"=>13, "26"=>5, "23"=>6, "7"=>13,
                "2"=>8, "29"=>6, "10"=>6, "25"=>5, "12"=>14, "6"=>8,
                "52"=>5, "13"=>8, "20"=>6, "30"=>4, "21"=>4, "28"=>5,
                "53"=>6, "17"=>8, "22"=>4, "24"=>6, "19"=>5, "54"=>1
              }
    assert_equal expected, @game_team_collection.lowest_opposing_team('3')
  end

  def test_it_can_list_total_games_played_with_opposing_team
    expected = {
                "15"=>["15", "15"],
                "5"=>["5", "5", "5", "5", "5"],
                "14"=>["14", "14", "14"]
              }
    assert_equal expected, @game_team_collection.total_opposing_team_games('3')
  end

  def test_it_can_find_losing_games_per_team_id
    assert_equal 204, @game_team_collection.losing_games('3').count
  end

  def test_it_can_find_team_id_for_highest_win_percentage
    assert_equal '15', @game_team_collection.highest_win_percentage('3')
  end

  def test_it_can_list_number_of_games_won_per_opposing_team
    expected = {
                "6"=>12, "15"=>17, "5"=>19, "14"=>12, "19"=>3, "52"=>5, "9"=>13,
                "29"=>6, "2"=>10, "4"=>9, "28"=>5, "8"=>16, "26"=>7, "1"=>11,
                "12"=>4, "13"=>5, "53"=>1, "18"=>4, "25"=>4, "20"=>3, "7"=>3,
                "30"=>5, "10"=>7, "24"=>4, "27"=>2, "22"=>3, "17"=>6, "16"=>4,
                "21"=>2, "54"=>1, "23"=>1
              }
    assert_equal expected, @game_team_collection.highest_opposing_team('3')
  end

  def test_it_can_find_highest_goals_by_team
    assert_equal 2, @game_team_collection.most_goals_scored('3')
  end

  def test_it_can_find_fewest_goals_by_team
    assert_equal 0, @game_team_collection.fewest_goals_scored('3')
  end
end
