require './test/test_helper'
require './lib/stat_tracker'
require './lib/game_collection'
require './lib/game'
require './lib/team_collection'
require './lib/team'
require './lib/game_team_collection'
require './lib/game_team'

class StatTrackerTest < Minitest::Test
  def setup ## instantiate using the from_csv
    @game_path = './data/fixtures/game_fixture.csv'
#     @game_path = './data/games.csv'
    @team_path = './data/fixtures/team_fixture.csv'
#     @team_path = './data/teams.csv'
    @game_teams_path = './data/fixtures/game_teams_fixture.csv'
#     @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_equal './data/fixtures/game_fixture.csv', @stat_tracker.games
    assert_equal './data/fixtures/team_fixture.csv', @stat_tracker.teams
    assert_equal './data/fixtures/game_teams_fixture.csv', @stat_tracker.game_teams
  end

  def test_it_can_have_game_collection
    skip 
    assert_instance_of GameCollection, @stat_tracker.game_collection
  end

  def test_it_can_have_team_collection
    assert_instance_of TeamCollection, @stat_tracker.team_collection
  end

  def test_it_can_have_game_team_collection
    assert_instance_of GameTeamCollection, @stat_tracker.game_team_collection
  end

  # JUDITH START HERE
  def test_it_can_get_highest_total_score
    skip
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_it_can_get_lowest_total_score
    skip
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_it_can_get_percentage_of_home_wins
    skip
    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end

  def test_it_can_get_percentage_of_visitor_wins
    skip
    assert_equal 0.36, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_get_percentage_of_ties
    skip
    assert_equal 0.20, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    skip
    expected = {
                "20122013"=>806,
                "20162017"=>1317,
                "20142015"=>1319,
                "20152016"=>1321,
                "20132014"=>1323,
                "20172018"=>1355
                }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    skip
    assert_equal 4.22, @stat_tracker.average_goals_per_game
  end

  def test_sum_of_goals_per_season
    skip
    assert_equal 3322, @stat_tracker.sum_of_goals_per_season("20122013")
  end

  def test_average_goals_per_season
    skip
    assert_equal 4.12, @stat_tracker.average_goals_per_season("20122013")
  end

  def test_average_goals_by_season
    skip
    expected = {
                "20122013"=>4.12,
                "20162017"=>4.23,
                "20142015"=>4.14,
                "20152016"=>4.16,
                "20132014"=>4.19,
                "20172018"=>4.44
                }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end
  # JUDITH END HERE

  # The below is Dan's code

  def test_it_can_get_team_info
    skip
    expected = {
                "team_id" => "30",
                "franchise_id" => "37",
                "team_name" => "Orlando City SC",
                "abbreviation" => "ORL",
                "link" => "/api/v1/teams/30"
                }
    assert_equal expected, @stat_tracker.team_info("30")
  end

  def test_it_can_filter_home_games_by_team
    skip
    assert_equal 5, @stat_tracker.home_games_filtered_by_team("19").count
  end

  def test_it_can_filter_away_games_by_team
    skip
    assert_equal 7, @stat_tracker.away_games_filtered_by_team("19").count
  end

  def test_it_can_group_home_games_by_season
    skip
    assert_equal true, @stat_tracker.home_games_grouped_by_season("19").keys.include?("20142015")
    assert_equal true,
    @stat_tracker.home_games_grouped_by_season("19").keys.include?("20162017")
    assert_equal false, @stat_tracker.home_games_grouped_by_season("19").keys.include?(:tie)
  end

  def test_it_can_group_away_games_by_season
    skip
    assert_equal true, @stat_tracker.away_games_grouped_by_season("19").keys.include?("20142015")
    assert_equal true,
    @stat_tracker.away_games_grouped_by_season("19").keys.include?("20122013")
    assert_equal false, @stat_tracker.away_games_grouped_by_season("19").keys.include?(:home_win)
  end

  def test_it_can_get_number_of_home_wins_in_season
    skip
    assert_equal true, @stat_tracker.season_home_wins("19").values.include?(2.0)
  end

  def test_it_can_get_number_of_away_wins_in_season
    skip
    assert_equal true, @stat_tracker.season_away_wins("19").values.include?(1.0)
  end

  def test_it_can_get_total_wins_in_a_season
    skip
    assert_equal true, @stat_tracker.win_count_by_season("19").values.include?(-1.0)
  end

  def test_it_can_get_best_season
    skip
    assert_equal "20162017", @stat_tracker.best_season("19")
  end

  def test_it_can_get_number_of_home_losses_in_season
    skip
    assert_equal true, @stat_tracker.season_home_losses("19").values.include?(-1.0)
  end

  def test_it_can_get_number_of_away_losses_in_season
    skip
    assert_equal true, @stat_tracker.season_away_losses("19").values.include?(-1.0)
  end

  def test_it_can_get_total_losses_in_a_season
    skip
    assert_equal true, @stat_tracker.loss_count_by_season("19").values.include?(1.0)
  end

  def test_it_can_get_worst_season
    skip
    assert_equal "20122013", @stat_tracker.worst_season("19")
  end

  def test_it_can_get_all_games_played_by_a_team
    skip
    assert_equal 12, @stat_tracker.combine_all_games_played("19").count
  end

  def test_it_can_total_wins_or_ties_for_a_team
    skip
    assert_equal 0.5, @stat_tracker.find_total_wins_or_ties("19")
  end

  def test_it_can_get_average_win_percentage
    skip
    assert_equal Float, @stat_tracker.average_win_percentage("19").class
  end

  def test_it_can_get_most_home_goals_scored
    skip
    assert_equal 3, @stat_tracker.most_home_goals_scored("19")
  end

  def test_it_can_get_most_away_goals_scored
    skip
    assert_equal 4, @stat_tracker.most_away_goals_scored("19")
  end

  def test_it_can_get_most_goals_scored
    skip
    assert_equal 4, @stat_tracker.most_goals_scored("19")
    assert_equal 3, @stat_tracker.most_goals_scored("30")
    assert_equal 4, @stat_tracker.most_goals_scored("26")
  end

  def test_it_can_get_fewest_home_goals_scored
    skip
    assert_equal 3, @stat_tracker.most_home_goals_scored("19")
  end

  def test_it_can_get_fewest_away_goals_scored
    skip
    assert_equal 4, @stat_tracker.most_away_goals_scored("19")
  end

  def test_it_can_get_fewest_goals_scored
    skip
    assert_equal 0, @stat_tracker.fewest_goals_scored("19")
    assert_equal 0, @stat_tracker.fewest_goals_scored("30")
  end

  def test_it_can_get_all_games_played_by_team
    skip
    assert_equal Array, @stat_tracker.all_games_played_by_team("19").class
  end

  def test_it_can_get_team_opponents
    skip
    assert_equal Hash, @stat_tracker.opponents("19").class
  end

  def test_it_can_get_opponent_win_percentages
    skip
    assert_equal Hash, @stat_tracker.opponent_win_percentages("19").class
  end

  def test_it_can_get_most_won_against_opponent
    skip
    assert_equal "30", @stat_tracker.most_won_against_opponent("19")
  end

  def test_it_can_get_favorite_opponent
    skip
    assert_equal "Orlando City SC", @stat_tracker.favorite_opponent("19")
  end

  def test_it_can_get_most_lost_against_opponent
    skip
    assert_equal "23", @stat_tracker.most_lost_against_opponent("19")
  end

  def test_it_can_get_rival
    skip
    assert_equal "Montreal Impact", @stat_tracker.rival("19")
  end

# The above is Dan's code
#################### START SEASON STATISTIC TESTS #########################

  def test_it_can_select_games_based_on_season
    skip
    assert_equal 1, @stat_tracker.games_by_season("20162017").count
    assert_equal 2, @stat_tracker.games_by_season("20122013").count
    assert_equal 3, @stat_tracker.games_by_season("20132014").count
    assert_equal Array, @stat_tracker.games_by_season("20162017").class
    assert_equal Game, @stat_tracker.games_by_season("20162017").first.class
  end

  def test_it_can_group_season_games_by_team_id
    skip
    assert_equal 1, @stat_tracker.season_games_grouped_by_team_id("20162017").count
    assert_equal 3, @stat_tracker.season_games_grouped_by_team_id("20132014").count
    assert_equal Game, @stat_tracker.season_games_grouped_by_team_id("20122013").values[0][0].class
    assert_equal "2016030235", @stat_tracker.season_games_grouped_by_team_id("20162017").keys[0]
  end

  def test_it_can_select_game_teams_by_season
    skip
    assert_equal 2, @stat_tracker.game_teams_by_season("20162017").count
    assert_equal 6, @stat_tracker.game_teams_by_season("20132014").count
    assert_equal GameTeam, @stat_tracker.game_teams_by_season("20162017")[0].class
  end

  def test_it_can_determine_the_winningest_coach
    skip
    expected1 = ["Darryl Sutter", "Ralph Krueger"]
    assert_includes expected1, @stat_tracker.winningest_coach("20122013")
    expected2 = ["Ken Hitchcock", "Alain Vigneault"]
    assert_includes expected2, @stat_tracker.winningest_coach("20142015")
    assert_equal "Mike Yeo", @stat_tracker.winningest_coach("20162017")
  end

  def test_it_can_determine_the_worst_coach
    skip
    expected = ["Patrick Roy", "Bruce Boudreau", "Ken Hitchcock"]
    assert_includes expected, @stat_tracker.worst_coach("20122013")
    assert_equal "Mike Yeo", @stat_tracker.worst_coach("20142015")
    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20162017")
  end

  def test_it_can_count_up_goals_for_teams_over_a_season
    skip
    assert_equal 4, @stat_tracker.total_season_goals_grouped_by_team("20122013")["22"]
    assert_equal ["19", "26", "22", "30"], @stat_tracker.total_season_goals_grouped_by_team("20122013").keys
    assert_equal [0,1,4,1], @stat_tracker.total_season_goals_grouped_by_team("20122013").values
  end

  def test_it_can_count_up_shots_for_teams_over_a_season
    skip
    assert_equal 9, @stat_tracker.total_season_shots_grouped_by_team("20122013")["30"]
    assert_equal ["19", "26", "22", "30"], @stat_tracker.total_season_shots_grouped_by_team("20122013").keys
    assert_equal [7,5,4,9], @stat_tracker.total_season_shots_grouped_by_team("20122013").values
  end

  def test_it_can_get_the_ratio_of_shots_to_goals_for_the_season
    skip
    assert_equal 0.2, @stat_tracker.season_ratio_goals_to_shots_grouped_by_team("20122013")["26"]
    assert_equal 1.0, @stat_tracker.season_ratio_goals_to_shots_grouped_by_team("20122013")["22"]
    assert_equal ["19", "26", "22", "30"], @stat_tracker.season_ratio_goals_to_shots_grouped_by_team("20122013").keys
  end

  def test_it_can_determine_the_most_accurate_team
    skip
    assert_equal "Washington Spirit FC", @stat_tracker.most_accurate_team("20122013")
    assert_equal "Houston Dynamo", @stat_tracker.most_accurate_team("20142015")
  end

  def test_it_can_determine_the_least_accurate_team
    skip
    assert_equal "Philadelphia Union", @stat_tracker.least_accurate_team("20122013")
    assert_equal "Orlando City SC", @stat_tracker.least_accurate_team("20142015")
    assert_equal "Minnesota United FC", @stat_tracker.least_accurate_team("20162017")
  end

  def test_it_can_return_team_name_based_off_of_team_id
    skip
    assert_equal "Philadelphia Union", @stat_tracker.team_name_based_off_of_team_id("19")
    assert_nil nil, @stat_tracker.team_name_based_off_of_team_id("5")
  end

  def test_it_can_count_up_tackles_for_a_team_for_the_season
    skip
    assert_equal 53, @stat_tracker.total_season_tackles_grouped_by_team("20122013")["26"]
    assert_equal ["19", "26", "22", "30"], @stat_tracker.total_season_tackles_grouped_by_team("20122013").keys
    assert_equal [39, 53, 15, 25], @stat_tracker.total_season_tackles_grouped_by_team("20122013").values
  end

  def test_it_can_determine_the_team_with_the_most_tackles
    skip
    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20122013")
    assert_equal "Orlando City SC", @stat_tracker.most_tackles("20142015")
    assert_equal "Philadelphia Union", @stat_tracker.most_tackles("20162017")
  end

  def test_it_can_determine_the_team_with_the_fewest_tackles
    skip
    assert_equal "Washington Spirit FC", @stat_tracker.fewest_tackles("20122013")
    assert_equal "DC United", @stat_tracker.fewest_tackles("20142015")
    assert_equal "Minnesota United FC", @stat_tracker.fewest_tackles("20162017")
  end

  def test_creates_collections_once
    skip
    collection1 = @stat_tracker.game_team_collection_to_use
    collection2 = @stat_tracker.game_team_collection_to_use
    assert_equal true, collection1 == collection2
    assert_equal Array, @stat_tracker.game_collection_to_use.class
    assert_equal Array, @stat_tracker.team_collection_to_use.class
    assert_equal Array, @stat_tracker.game_team_collection_to_use.class
  end
  ########################## END SEASON STATISTICS #############################
  # start of sienna's league stats
  def test_it_can_find_all_home_game_teams
    assert_equal 9, @stat_tracker.home_game_teams.count
    assert_equal GameTeam, @stat_tracker.home_game_teams[0].class
    assert_equal "home", @stat_tracker.home_game_teams[0].hoa
  end

  def test_it_can_group_home_game_teams_by_team_id
    assert_equal ["30", "19", "24", "26", "14"], @stat_tracker.home_game_teams_by_team.keys
    assert_equal 4, @stat_tracker.home_game_teams_by_team["30"].count
    assert_equal GameTeam, @stat_tracker.home_game_teams_by_team["30"][0].class
    assert_equal "home", @stat_tracker.home_game_teams_by_team["30"][0].hoa
  end

  def test_it_can_determine_total_home_games_grouped_by_team
    assert_equal ["30","19", "24", "26", "14"], @stat_tracker.total_home_goals_grouped_by_team.keys
    assert_equal [6, 4, 2, 1, 3], @stat_tracker.total_home_goals_grouped_by_team.values
    assert_equal 4, @stat_tracker.total_home_goals_grouped_by_team["19"]
  end

  def test_it_can_determine_total_home_goals_grouped_by_team
    assert_equal ["30","19", "24", "26", "14"], @stat_tracker.total_home_games_grouped_by_team.keys
    assert_equal [4, 2, 1, 1, 1], @stat_tracker.total_home_games_grouped_by_team.values
    assert_equal 2, @stat_tracker.total_home_games_grouped_by_team["19"]
  end

  def test_it_can_determine_ratio_of_home_goals_to_games_grouped_by_team
    assert_equal ["30","19", "24", "26", "14"], @stat_tracker.ratio_home_goals_to_games_grouped_by_team.keys
    assert_equal [1.5, 2.0, 2.0, 1.0, 3.0], @stat_tracker.ratio_home_goals_to_games_grouped_by_team.values
    assert_equal 2.0, @stat_tracker.ratio_home_goals_to_games_grouped_by_team["19"]
  end

  def test_it_can_find_team_id_with_best_home_goals_to_games_ratio
    assert_equal "14", @stat_tracker.find_team_id_with_best_home_goals_to_games_ratio
  end

  def test_it_can_find_team_with_worst_home_goals_to_games_ratio
    assert_equal "26", @stat_tracker.find_team_id_with_worst_home_goals_to_games_ratio
  end

  def test_highest_scoring_home_team
    assert_equal "DC United", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal "FC Cincinnati", @stat_tracker.lowest_scoring_home_team
  end
  #end of sienna's league stats
end
