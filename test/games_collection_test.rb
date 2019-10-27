require_relative 'test_helper'
class GamesCollectionTest < Minitest::Test

  def setup
    @games_collection = GamesCollection.new('./data/dummy_games.csv')
  end

  def test_it_exists
    assert_instance_of GamesCollection, @games_collection
  end

  def test_it_initializes_attributes
    assert_equal 99, @games_collection.games.length
    assert_equal true, @games_collection.games.all? {|game| game.is_a?(Game)}
  end

  def test_it_knows_the_number_of_games_in_each_season
    expected = [
      57,
      4,
      16,
      16,
      6
    ]
    assert_equal expected, @games_collection.number_of_games_in_each_season
  end

  def test_it_can_count_game_by_season
    expected = {
      "20122013" => 57,
      "20162017" => 4,
      "20142015" => 16,
      "20152016" => 16,
      "20132014" => 6
    }
    assert_equal expected, @games_collection.count_of_games_by_season
  end

  def test_it_grabs_highest_total_score
    assert_equal 7, @games_collection.highest_total_score
  end

  def test_it_grabs_lowest_total_score
    assert_equal 1, @games_collection.lowest_total_score
  end

  def test_it_can_return_total_goals_across_all_games
    assert_equal 387, @games_collection.total_goals(@games_collection.games)
  end

  def test_it_can_get_array_of_every_element_in_a_given_column
    assert_instance_of Array, @games_collection.every("game_id", @games_collection.games)
    assert_equal 99, @games_collection.every("game_id", @games_collection.games).length
  end

  def test_it_can_get_array_of_every_unique_element_in_a_given_column
    assert_equal 99, @games_collection.every_unique("game_id", @games_collection.games).length
  end

  def test_it_can_count_total_unique_elements_in_a_given_column
    assert_equal 99, @games_collection.total_unique("game_id", @games_collection.games)
  end

  def test_it_can_total_goals_for_given_game
    assert_equal 5, @games_collection.goals(@games_collection.games[0])
    assert_equal 3, @games_collection.goals(@games_collection.games[2])
    assert_equal 4, @games_collection.goals(@games_collection.games[4])
  end

  def test_it_can_calculate_average_goals_for_selection_of_games
    assert_equal 4.40, @games_collection.average_goals_in(@games_collection.games[0..4])
  end

  def test_it_can_calculate_average_goals_per_game
    assert_equal 3.91, @games_collection.average_goals_per_game
  end

  def test_it_can_select_all_games_in_given_season
    assert_equal 4, @games_collection.all_games_in_season("20162017").length
    assert_equal 16, @games_collection.all_games_in_season("20142015").length
  end

  def test_it_can_return_hash_of_average_goals_by_season
    expected_hash = {
                      "20122013"=>3.86,
                      "20162017"=>4.75,
                      "20142015"=>3.75,
                      "20152016"=>3.88,
                      "20132014"=>4.33
                    }
    assert_equal expected_hash, @games_collection.average_goals_by_season
  end

  def test_it_can_tell_us_each_unique_home_team_id
    #this validates that we're getting a condensed list of teams
    assert_equal 17, @games_collection.home_teams.length
  end

  def test_it_can_tell_us_total_team_home_goals
    assert_equal 12, @games_collection.total_home_goals("6")
  end

  def test_it_can_tell_us_total_team_home_games
    assert_equal 5, @games_collection.total_home_games("6")
  end

  def test_it_can_tell_us_each_unique_away_team_id
    assert_equal 17, @games_collection.away_teams.length
  end

  def test_it_can_calculate_average_home_score_of_given_team
    assert_equal 2.4, @games_collection.average_home_score_of_team("6")
  end

  def test_it_can_tell_us_highest_scoring_home_team
    assert_equal "9", @games_collection.highest_scoring_home_team
  end

  def test_it_can_tell_us_highest_scoring_visitor
    assert_equal "6", @games_collection.highest_scoring_visitor
  end

  def test_it_can_tell_us_lowest_scoring_home_team
    assert_equal "4", @games_collection.lowest_scoring_home_team
  end

  def test_it_can_tell_us_lowest_scoring_visitor
    assert_equal "2", @games_collection.lowest_scoring_visitor
  end


# calculate: (total_wins_for_a_team_id / total_games_for_a_team_id)
# calculate win percentage for given_set_of_games
# get all games in a particular season (team_game_list)
# calculate win_percentage for a given_season for a team_id
# get list of unique seasons
# for each season, calcul;ate win percentage for a given team
# get highest
# get lowest

  def test_it_knows_all_the_games_per_teams
    # skip
    expected = [
      @games_collection.games[39],
      @games_collection.games[40],
      @games_collection.games[41],
      @games_collection.games[42],
      @games_collection.games[43],
      @games_collection.games[44]
    ]
    assert_equal expected, @games_collection.games_with_team("2").sort_by { |game| game.game_id}
  end

  def test_it_can_tell_away_win
    assert_equal true, @games_collection.away_win?(@games_collection.games[3])
    assert_equal false, @games_collection.away_win?(@games_collection.games[0])
  end

  def test_it_can_count_away_wins
    assert_equal 0, @games_collection.total_away_wins("2", "20122013")
  end

  def test_it_can_count_home_wins
    assert_equal 2, @games_collection.total_home_wins("2", "20122013")
  end

  def test_it_can_count_total_team_wins
    assert_equal 2, @games_collection.total_team_wins("2", "20122013")
  end

  def test_it_can_calculate_win_percentage_for_a_team
    assert_equal 0.33, @games_collection.team_win_percentage("2", "20122013")
  end

  def test_it_can_list_seasons
    expected = [
      "20122013",
      "20162017",
      "20142015",
      "20152016",
      "20132014"
    ]
    assert_equal expected, @games_collection.unique_seasons
  end

  def test_it_can_list_seasons_a_team_played_in
    assert_equal ["20122013", "20152016", "20142015"], @games_collection.team_seasons("5")
  end

  def test_it_can_tell_us_best_season_for_given_team
    assert_equal "20152016", @games_collection.best_season("5")
  end

  def test_it_can_tell_us_worst_season_for_given_team
    assert_equal "20142015", @games_collection.worst_season("5")
  end

  def test_it_can_get_total_wins_across_seasons
    assert_equal 8, @games_collection.total_wins_across_seasons("5")
  end

  def test_it_can_calculate_average_win_percentage_across_seasons
    assert_equal 0.40, @games_collection.average_win_percentage("5")
  end

  def test_it_can_count_number_of_ties_of_team_in_given_season
    assert_equal 1, @games_collection.total_team_ties_in_season("5", "20152016")
  end
end
