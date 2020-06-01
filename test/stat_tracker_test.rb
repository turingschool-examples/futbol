require "simplecov"
SimpleCov.start
require "minitest/autorun"
require "./lib/stat_tracker"
require 'pry'

class StatTrackerTest < Minitest::Test
  def setup

    game_path = './data/games.csv'
    team_path = './test/data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_works
    StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_tracker_can_fetch_game_data
    assert_equal 7441, @stat_tracker.games.count
    assert_instance_of Game, @stat_tracker.games.first
  end

  def test_tracker_can_fetch_team_data
    assert_equal 32, @stat_tracker.teams.count
  end

  def test_tracker_can_fetch_game_team_data
    assert_equal 14882, @stat_tracker.game_teams.count
  end

  def test_it_returns_team_info_hash
    expected = {
                "team_id" => "54",
                "franchise_id" => "38",
                "team_name" => "Reign FC",
                "abbreviation" => "RFC",
                "link" => "/api/v1/teams/54"
               }
    assert_equal expected, @stat_tracker.team_info(54)
  end

  def test_it_returns_best_season_string
    assert_equal "20132014", @stat_tracker.best_season(6)
  end

  def test_it_returns_worst_season_string
    assert_equal "20142015", @stat_tracker.worst_season(6)
  end


  def test_it_can_count_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_find_team_by_id
    # skip
    assert_equal "Toronto FC", @stat_tracker.find_team_by_id(20).team_name
  end

  def test_it_can_find_scores_by_team
    # skip
    expected = {"3"=>[2, 2, 1, 2, 1],
       "6"=>[3, 3, 2, 3, 3, 3, 4, 2, 1],
        "5"=>[0, 1, 1, 0], "17"=>[1, 2, 3, 2, 1, 3, 1],
         "16"=>[2, 1, 1, 0, 2, 2, 2, 2, 3, 2, 3, 3],
          "9"=>[2, 1, 4, 3, 4],
          "8"=>[2, 3, 1, 2, 1],
           "30"=>[1, 2, 3, 0, 1]
       }
    assert_equal expected, @stat_tracker.scores_by_team
  end

  def test_it_can_find_average_scores_by_team
    # skip
    expected = {"3"=>1.6,
      "6"=>2.6666666666666665,
      "5"=>0.5,
       "17"=>1.8571428571428572,
        "16"=>1.9166666666666667,
         "9"=>2.8,
          "8"=>1.8,
           "30"=>1.4
         }
    assert_equal expected, @stat_tracker.average_scores_by_team
  end

  def test_it_has_the_best_offense
    # skip
     assert_equal "New York City FC", @stat_tracker.best_offense
  end

  def test_it_can_find_the_worst_offense
    # skip
    assert_equal "Sporting Kansas City", @stat_tracker.worst_offense
  end

  def test_it_can_find_scores_by_away_team
    # skip
    expected = {"3"=>[2, 2, 1, 1, 0, 1, 3],
       "6"=>[2, 3, 3, 4],
        "5"=>[1, 0, 3, 2, 2],
         "17"=>[1, 2, 1, 1, 1, 3, 2, 3],
          "16"=>[1, 0, 2, 2, 3, 1, 3],
           "9"=>[2, 1, 4], "8"=>[1, 2],
            "30"=>[1, 2, 1],
             "26"=>[1, 1, 3, 1, 2, 3],
              "19"=>[0, 3, 1],
              "24"=>[2, 2, 3, 3],
               "2"=>[0, 2, 0],
                "15"=>[3, 3, 0],
                 "20"=>[2, 2]
       }
    assert_equal expected, @stat_tracker.scores_by_away_team
  end

  def test_it_can_find_the_highest_scoring_visitor
    # skip
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_it_can_find_the_lowest_scoring_visitor
    # skip
    assert_equal "Seattle Sounders FC", @stat_tracker.lowest_scoring_visitor
  end

  def test_it_can_find_the_highest_scoring_home_team
    # skip
    assert_equal "New York City FC", @stat_tracker.highest_scoring_home_team
  end

  def test_it_can_find_the_lowest_scoring_home_team
    # skip
    assert_equal "Orlando City SC", @stat_tracker.lowest_scoring_home_team
  end

  def test_tracker_has_all_games_per_season
    assert_equal 57, @stat_tracker.all_games_per_season("20122013").count
    assert_instance_of Game,  @stat_tracker.all_games_per_season("20122013").first

    expected = @stat_tracker.all_games_per_season("20122013").map{|game| game.season}.uniq
    assert_equal 1, expected.size
    assert_equal "20122013", expected.first
  end

  def test_tracker_has_all_game_teams_per_season
    game_teams_in_a_season = @stat_tracker.all_game_teams_per_season("20122013")
    assert_equal 52, game_teams_in_a_season.count

    game_teams_in_a_season.each do |game_team|
      assert_instance_of GameTeam, game_team
    end
  end

  def test_tracker_has_all_games_by_head_coach
     expected_list_of_coaches = ["John Tortorella",
      "Claude Julien",
      "Dan Bylsma",
      "Mike Babcock",
      "Joel Quenneville",
      "Paul MacLean",
      "Michel Therrien",
      "Mike Yeo"
    ]
    assert_kind_of Hash, @stat_tracker.games_by_head_coach("20122013")
    assert_equal expected_list_of_coaches, @stat_tracker.games_by_head_coach("20122013").keys
  end

  def test_tracker_can_group_coach_with_win_counts
    expected = {
        "John Tortorella"=>0,
        "Claude Julien"=>9,
        "Dan Bylsma"=>0,
        "Mike Babcock"=>4,
        "Joel Quenneville"=>7,
        "Paul MacLean"=>3,
        "Michel Therrien"=>1,
        "Mike Yeo"=>1
      }
    assert_equal expected, @stat_tracker.coach_per_total_win("20122013")
  end
  
# start game stat tests
  def test_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_percentage_home_wins # 38 home wins in test data
    assert_equal 0.63, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins # 20 away wins in test data
    assert_equal 0.33, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties # 2 draws in test data
    assert_equal 0.03, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = expected = {
      "20122013"=>57,
      "20162017"=>3
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game #235 goals in test data
    assert_equal 3.92, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {
      "20122013"=>3.86, # 220 goals in test data
      "20162017"=>5 # 15 goals in test data
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_tracker_has_the_winnest_coach
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20122013")
  end

  def test_tracker_has_the_worst_coach
    assert_equal "John Tortorella", @stat_tracker.worst_coach("20122013")
  end

  def test_tracker_has_games_per_team_ids_for_a_season
    assert_kind_of  Hash, @stat_tracker.team_id_group("20122013")
  end

  def test_tracker_has_ratio_of_shots_per_season
    expected = {
                 "3"=>21.05,
                 "6"=>31.58,
                 "5"=>6.25,
                 "17"=>28.26,
                 "16"=>23.23,
                 "9"=>38.89,
                 "8"=>20.93,
                 "30"=>21.21
               }

    assert_equal expected, @stat_tracker.ratio_of_shots("20122013")
    assert_equal "9", @stat_tracker.best_accurate_team_id("20122013")
    assert_equal "5", @stat_tracker.least_accurate_team_id("20122013")
  end

  def test_tracker_can_find_team_by_id
    assert_instance_of Team , @stat_tracker.find_team_by_id("5")
     assert_equal "Sporting Kansas City", @stat_tracker.find_team_by_id("5").team_name
  end

  def test_tracker_has_the_accurate_team
    assert_equal "New York City FC", @stat_tracker.most_accurate_team("20122013")
  end

  def test_tracker_has_the_accurate_team
    assert_equal "Sporting Kansas City", @stat_tracker.least_accurate_team("20122013")
  end

  def test_tracker_has_total_tackles_per_season
    expected = {
      "3"=>179,
      "6"=>271,
      "5"=>150,
      "17"=>219,
      "16"=>299,
      "9"=>181,
      "8"=>173,
      "30"=>165
    }
    assert_equal expected, @stat_tracker.total_tackles_team_per_season("20122013")
  end

  def test_tracker_can_get_team_name_with_id
    assert_equal "Sporting Kansas City", @stat_tracker.get_team_name_with_id("5")
  end

  def test_tracker_has_the_most_tackles
    assert_equal "New England Revolution", @stat_tracker.most_tackles("20122013")
  end

  def test_tracker_has_the_least_tackles
    assert_equal "Sporting Kansas City", @stat_tracker.fewest_tackles("20122013")
  end
  
  def test_it_returns_average_win_percentage_string
    assert_equal 0.49, @stat_tracker.average_win_percentage(6)
  end

  def test_it_can_return_most_goals_scored_integer
    assert_equal "7", @stat_tracker.most_goals_scored(18)
  end

  def test_it_can_return_fewest_goals_scored_integer
    assert_equal "0", @stat_tracker.fewest_goals_scored(18)
  end

  def test_it_can_return_favorite_opponent_string
    assert_equal "DC United", @stat_tracker.favorite_opponent(18)
  end
end
