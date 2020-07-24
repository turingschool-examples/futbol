require "./test/test_helper"


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

  def test_StatTracker_can_find_highest_total_score
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_the_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_average_goals_per_game
    assert_equal 4.22, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    @stat_tracker.average_goals_by_season
    expected = {"20122013" => 4.12, "20162017" => 4.23, "20142015" => 4.14, "20152016" => 4.16, "20132014" => 4.19, "20172018" => 4.44 }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_it_can_find_percentage_home_wins
    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end

  def test_it_can_find_percentage_visitor_wins
    assert_equal 0.36, @stat_tracker.percentage_visitor_wins
  end

  def test_can_find_percentage_tie
     assert_equal 0.20, @stat_tracker.percentage_tie
   end

  def test_count_games_by_season
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
     assert_equal 32, @stat_tracker.count_of_teams
   end

   def test_highest_scoring_home_team
     assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
   end


  def test_it_can_create_an_away_goals_and_team_id_hash
    assert_equal 32, @stat_tracker.total_goals_by_away_team.count
    assert_equal Hash, @stat_tracker.total_goals_by_away_team.class
    assert_equal 458, @stat_tracker.total_goals_by_away_team["20"]
  end

  def test_it_can_create_hash_with_total_games_played_by_away_team
    assert_equal 32, @stat_tracker.away_teams_game_count_by_team_id.count
    assert_equal Hash, @stat_tracker.away_teams_game_count_by_team_id.class
    assert_equal 266, @stat_tracker.away_teams_game_count_by_team_id["3"]
    assert_nil @stat_tracker.away_teams_game_count_by_team_id["56"]
  end

  def test_it_can_find_highest_total_goals_by_away_team
    assert_equal String, @stat_tracker.highest_total_goals_by_away_team[0].class
    assert_equal Integer, @stat_tracker.highest_total_goals_by_away_team[1].class
    assert_equal 2, @stat_tracker.highest_total_goals_by_away_team.count
    assert_equal Array, @stat_tracker.highest_total_goals_by_away_team.class
  end

  def test_it_can_calculate_overal_average_by_team
    assert_equal 32, @stat_tracker.overall_average_scores_by_away_team.count
    assert_equal Hash, @stat_tracker.overall_average_scores_by_away_team.class
    assert_equal 2.2450592885375493, @stat_tracker.overall_average_scores_by_away_team["6"]
  end

  def test_it_can_calculate_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Utah Royals FC" ,@stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_find_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
  end


   def test_lowest_scoring_home_team

    assert_equal "Utah Royals FC" ,@stat_tracker.lowest_scoring_home_team
   end

   def test_it_can_return_best_offense

    assert_equal "Reign FC", @stat_tracker.best_offense
  end

  def test_it_can_return_worst_offense

    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
  end

  def test_it_has_a_winningest_coach
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
  end

  def test_it_has_a_worst_coach
    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
    assert "Craig MacTavish" || "Ted Nolan", @stat_tracker.worst_coach("20142015")
  end

  def test_it_can_retrieve_team_info_from_team_id
    expected = {"team_id" => "18", "franchise_id" => "34", "team_name" => "Minnesota United FC", "abbreviation" => "MIN", "link" => "/api/v1/teams/18" }

    assert_equal expected, @stat_tracker.team_info("18")
  end

  def test_it_can_retrieve_team_average_win_percentage

    assert_equal 0.49, @stat_tracker.average_win_percentage("6")
  end

  def test_it_can_find_most_accurate_team_by_season

    assert_equal "Real Salt Lake", @stat_tracker.most_accurate_team("20132014")
    assert_equal "Toronto FC", @stat_tracker.most_accurate_team("20142015")
  end

  def test_it_can_find_least_accurate_team_by_season

    assert_equal "New York City FC", @stat_tracker.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @stat_tracker.least_accurate_team("20142015")
  end

  def test_it_can_find_most_goals_scored_for_team

    assert_equal 7, @stat_tracker.most_goals_scored("18")
  end

  def test_it_can_find_fewest_goals_scored_for_team

    assert_equal 0, @stat_tracker.fewest_goals_scored("18")
  end
end
