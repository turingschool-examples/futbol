require "./test/test_helper"
# require 'minitest/autorun'


class StatTrackerTest < MiniTest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exist
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_find_the_fewest_tackles
    #registers as skipped
    assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
    assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20142015")
  end

  def test_it_can_calculate_the_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_average_goals_per_game
    assert_equal 4.22, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    skip
    @stat_tracker.average_goals_by_season
    expected = {"20122013" => 4.12, "20162017" => 4.23, "20142015" => 4.14, "20152016" => 4.16, "20132014" => 4.19, "20172018" => 4.44 }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_it_can_find_percentage_home_wins
    skip
    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end


  def test_can_find_percentage_ties
    skip
    assert_equal 0.20, @stat_tracker.percentage_ties
  end

  def test_count_games_by_season
    skip
     expected = {"20122013" => 806,
                 "20162017" => 1317,
                 "20142015" => 1319,
                 "20152016" => 1321,
                 "20132014" => 1323,
                 "20172018" => 1355
                  }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_count_of_teams
    skip
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_highest_scoring_home_team
    skip
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end


  def test_it_can_create_an_away_goals_and_team_id_hash
    skip
    assert_equal 32, @stat_tracker.total_goals_by_away_team.count
    assert_equal Hash, @stat_tracker.total_goals_by_away_team.class
    assert_equal 458, @stat_tracker.total_goals_by_away_team["20"]
  end

  def test_it_can_create_hash_with_total_games_played_by_away_team
    skip
    assert_equal 32, @stat_tracker.away_teams_game_count_by_team_id.count
    assert_equal Hash, @stat_tracker.away_teams_game_count_by_team_id.class
    assert_equal 266, @stat_tracker.away_teams_game_count_by_team_id["3"]
    assert_nil @stat_tracker.away_teams_game_count_by_team_id["56"]
  end

  def test_it_can_find_highest_total_goals_by_away_team
    skip
    assert_equal String, @stat_tracker.highest_total_goals_by_away_team[0].class
    assert_equal Integer, @stat_tracker.highest_total_goals_by_away_team[1].class
    assert_equal 2, @stat_tracker.highest_total_goals_by_away_team.count
    assert_equal Array, @stat_tracker.highest_total_goals_by_away_team.class
  end

  def test_it_can_calculate_overal_average_by_team
    skip
    assert_equal 32, @stat_tracker.overall_average_scores_by_away_team.count
    assert_equal Hash, @stat_tracker.overall_average_scores_by_away_team.class
    assert_equal 2.2450592885375493, @stat_tracker.overall_average_scores_by_away_team["6"]
  end

  def test_it_can_calculate_highest_scoring_visitor
    skip
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    skip
    assert_equal "Utah Royals FC" ,@stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_find_lowest_scoring_visitor
    skip
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    skip

    assert_equal "Utah Royals FC" ,@stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_return_best_offense
    skip

    assert_equal "Reign FC", @stat_tracker.best_offense
  end

  def test_it_can_return_worst_offense
    skip

    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
  end

  def test_it_has_a_winningest_coach
    skip
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
  end

  def test_it_has_a_worst_coach
    skip
    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
    assert "Craig MacTavish" || "Ted Nolan", @stat_tracker.worst_coach("20142015")
  end

  def test_it_can_retrieve_team_info_from_team_id
    skip
    expected = {"team_id" => "18", "franchise_id" => "34", "team_name" => "Minnesota United FC", "abbreviation" => "MIN", "link" => "/api/v1/teams/18" }

    assert_equal expected, @stat_tracker.team_info("18")
  end

  def test_it_can_retrieve_team_average_win_percentage
    skip

    assert_equal 0.49, @stat_tracker.average_win_percentage("6")
  end

  def test_it_can_find_most_accurate_team_by_season
    skip

    assert_equal "Real Salt Lake", @stat_tracker.most_accurate_team("20132014")
    assert_equal "Toronto FC", @stat_tracker.most_accurate_team("20142015")
  end

  def test_it_can_find_least_accurate_team_by_season
    skip

    assert_equal "New York City FC", @stat_tracker.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @stat_tracker.least_accurate_team("20142015")
  end

  def test_it_can_find_most_goals_scored_for_team
    skip

    assert_equal 7, @stat_tracker.most_goals_scored("18")
  end

  def test_it_can_find_fewest_goals_scored_for_team
    skip

    assert_equal 0, @stat_tracker.fewest_goals_scored("18")
  end

  def test_best_season
    skip
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_worst_season
    skip
    assert_equal "20142015", @stat_tracker.worst_season("6")
  end

  def test_find_the_fewest_tackles
    skip
   assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
   assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20142015")
 end

  def test_find_the_most_tackles
    skip
    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @stat_tracker.most_tackles("20142015")
  end

  def test_it_can_identify_favorite_opponent
    skip
  assert_equal "DC United", @stat_tracker.favorite_opponent("18")
  end

  def test_it_can_find_all_opponents
    skip
    assert_equal 31, @stat_tracker.opponents_of("18").count
    assert_equal Hash, @stat_tracker.opponents_of("18").class

    assert_equal 30, @stat_tracker.opponents_of("54").count
    assert_equal Hash, @stat_tracker.opponents_of("54").class
  end

  def test_it_can_find_team_name
    skip
    assert_equal "Minnesota United FC", @stat_tracker.find_team_name("18")
    assert_equal "Reign FC", @stat_tracker.find_team_name("54")
  end

  def test_it_can_count_games_won_against_opponents
    skip
    expected = {
     "19"=>15,
     "52"=>14,
     "21"=>14,
     "16"=>18,
     "1"=>5,
     "29"=>7,
     "8"=>4,
     "23"=>6,
     "15"=>3,
     "25"=>13,
     "20"=>6,
     "28"=>11,
     "24"=>13,
     "5"=>4,
     "2"=>5,
     "7"=>6,
     "14"=>8,
     "22"=>12,
     "3"=>4,
     "10"=>2,
     "9"=>6,
     "26"=>7,
     "6"=>4,
     "12"=>3,
     "30"=>10,
     "27"=>2,
     "17"=>4,
     "53"=>6,
     "4"=>3,
     "54"=>1,
     "13"=>1}
    assert_equal expected, @stat_tracker.games_won_by_team("18")

  end

  def test_it_can_calculate_average_win_percentage
    skip
    expected = {
       "19"=>0.4411764705882353,
       "52"=>0.45161290322580644,
       "21"=>0.4375,
       "16"=>0.47368421052631576,
       "1"=>0.5,
       "29"=>0.4666666666666667,
       "8"=>0.4,
       "23"=>0.3333333333333333,
       "15"=>0.3,
       "25"=>0.48148148148148145,
       "20"=>0.3333333333333333,
       "28"=>0.44,
       "24"=>0.41935483870967744,
       "5"=>0.25,
       "2"=>0.5,
       "7"=>0.6,
       "14"=>0.8,
       "22"=>0.6666666666666666,
       "3"=>0.4,
       "10"=>0.2,
       "9"=>0.6,
       "26"=>0.3888888888888889,
       "6"=>0.4,
       "12"=>0.3,
       "30"=>0.37037037037037035,
       "27"=>0.3333333333333333,
       "17"=>0.2857142857142857,
       "53"=>0.5,
       "4"=>0.3,
       "54"=>0.3333333333333333,
       "13"=>0.1}
    assert_equal expected, @stat_tracker.average_win_percentage_by_opponents_of("18")

  end

  def test_it_can_find_rival
    skip
    assert_equal "Houston Dash", @stat_tracker.rival("18")

  end

  def test_it_can_find_least_accurate_team_by_season
    skip

    assert_equal "New York City FC", @stat_tracker.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @stat_tracker.least_accurate_team("20142015")
  end

  def test_it_can_find_most_goals_scored_for_team
    skip

    assert_equal 7, @stat_tracker.most_goals_scored("18")
  end

  def test_it_can_find_fewest_goals_scored_for_team
    skip

    assert_equal 0, @stat_tracker.fewest_goals_scored("18")
  end

  def test_best_season
    skip
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_worst_season
    skip
    assert_equal "20142015", @stat_tracker.worst_season("6")
  end

  def test_find_the_fewest_tackles
    skip
   assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
   assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20142015")
  end

  def test_find_the_most_tackles
    skip
    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @stat_tracker.most_tackles("20142015")
  end

  def test_it_can_group_team_id_with_game_teams_objects
    skip

  assert_equal "3", @stat_tracker.team_by_id.keys[0]
  assert_equal "6", @stat_tracker.team_by_id.keys[1]
  end

  def test_it_can_return_accuracy_for_each_team
    skip

  assert_equal ["16", 0.3042362002567394], @stat_tracker.team_accuracy("20132014").first
  end

  def test_games_by_team
    skip

  assert_equal 8, @stat_tracker.games_by_team("18").first.shots
  end

  def test_it_pair_goals_scored_with_each_instance
    skip

  assert_equal [2, 3, 1, 0, 5, 4, 7], @stat_tracker.team_goals("18").keys
  end

  def test_total_goals_by_id
    skip

  assert_equal ["3", 1129], @stat_tracker.total_goals_by_id.first
  end

  def test_total_games_by_id
    skip

  assert_equal ["3", 531], @stat_tracker.total_games_by_id.first
  end

  def test_average_goals_all_seasons_by_id
    skip

  assert_equal ["3", 2.13], @stat_tracker.average_goals_all_seasons_by_id.first
  end
end
