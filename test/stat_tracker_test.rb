require "./lib/stat_tracker"
require "minitest/autorun"
require "minitest/pride"

class StatTrackerTest < MiniTest::Test

  def test_it_exists
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_gets_highest_total_score
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 11, stat_tracker.highest_total_score
  end

  def test_it_gets_lowest_total_score
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 0, stat_tracker.lowest_total_score
  end

  def test_it_gets_percentage_home_wins
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 0.44, stat_tracker.percentage_home_wins
  end

  def test_it_gets_percentage_visitor_wins
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 0.36, stat_tracker.percentage_visitor_wins
  end

  def test_it_gets_percentage_ties
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 0.20, stat_tracker.percentage_ties
  end

  def test_it_gets_count_of_games_by_season
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    assert_equal expected, stat_tracker.count_of_games_by_season
  end

  def test_it_gets_average_goals_per_game
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 4.22, stat_tracker.average_goals_per_game
  end

  def test_it_gets_average_goals_by_season
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    assert_equal expected, stat_tracker.average_goals_by_season
  end

  # League Statistics count_of_teams method DONE
  def test_it_gets_count_of_teams
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 32, stat_tracker.count_of_teams
  end

  # League Statistics count_of_teams method HELPER DONE
  def test_convert_team_id_to_name
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "FC Dallas", stat_tracker.team_name("6")
  end

  # League Statistics HELPER HELPER method refactored into one
  def test_it_can_get_scores_by_team
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal Hash, stat_tracker.scores("away").class
    assert_equal 32, stat_tracker.scores("away").count
    assert_equal true, stat_tracker.scores("away").all? do |team_id, scores|
      team_id.is_a?(String) && scores.is_a?(Array)
    end
  end

  # League Statistics HELPER method
  def test_it_can_get_all_team_scores
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal Hash, stat_tracker.team_scores.class
    assert_equal 32, stat_tracker.team_scores.count
    assert_equal true, stat_tracker.team_scores.all? do |team_id, scores|
      team_id.is_a?(String) && scores.is_a?(Array)
    end
  end

  # League Statistics HELPER method
  def test_it_can_get_visitor_scores
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal Hash, stat_tracker.visitor_scores.class
    assert_equal 32, stat_tracker.visitor_scores.count
    assert_equal true, stat_tracker.visitor_scores.all? do |team_id, scores|
      team_id.is_a?(String) && scores.is_a?(Array)
    end
  end

  # League Statistics HELPER method
  def test_it_can_get_home_team_scores
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal Hash, stat_tracker.home_team_scores.class
    assert_equal 32, stat_tracker.home_team_scores.count
    assert_equal true, stat_tracker.home_team_scores.all? do |team_id, scores|
      team_id.is_a?(String) && scores.is_a?(Array)
    end
  end

  def test_average_scores
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    visitor_scores = stat_tracker.visitor_scores
      expected = {
        "3"=>2.15,
        "6"=>2.25,
        "5"=>2.18,
        "17"=>2.04,
        "16"=>2.10,
        "9"=>2.01,
        "8"=>2.01,
        "30"=>2.01,
        "26"=>2.03,
        "19"=>2.04,
        "24"=>2.14,
        "2"=>2.10,
        "15"=>2.20,
        "20"=>1.93,
        "14"=>2.12,
        "28"=>2.13,
        "4"=>1.97,
        "21"=>1.91,
        "25"=>2.12,
        "13"=>1.95,
        "18"=>2.05,
        "10"=>1.95,
        "29"=>2.12,
        "52"=>2.04,
        "54"=>2.10,
        "1"=>1.90,
        "12"=>2.02,
        "23"=>1.94,
        "22"=>2.03,
        "7"=>1.88,
        "27"=>1.85,
        "53"=>1.85
      }
    assert_equal expected, stat_tracker.average_scores(visitor_scores)
  end

  def test_average_visitor_scores
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

      expected = {
        "3"=>2.15,
        "6"=>2.25,
        "5"=>2.18,
        "17"=>2.04,
        "16"=>2.10,
        "9"=>2.01,
        "8"=>2.01,
        "30"=>2.01,
        "26"=>2.03,
        "19"=>2.04,
        "24"=>2.14,
        "2"=>2.10,
        "15"=>2.20,
        "20"=>1.93,
        "14"=>2.12,
        "28"=>2.13,
        "4"=>1.97,
        "21"=>1.91,
        "25"=>2.12,
        "13"=>1.95,
        "18"=>2.05,
        "10"=>1.95,
        "29"=>2.12,
        "52"=>2.04,
        "54"=>2.10,
        "1"=>1.90,
        "12"=>2.02,
        "23"=>1.94,
        "22"=>2.03,
        "7"=>1.88,
        "27"=>1.85,
        "53"=>1.85
      }
    assert_equal expected, stat_tracker.average_visitor_scores
  end

  def test_average_team_scores
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

      expected = {
        "3"=>2.13,
        "6"=>2.26,
        "5"=>2.29,
        "17"=>2.06,
        "16"=>2.16,
        "9"=>2.11,
        "8"=>2.05,
        "30"=>2.12,
        "26"=>2.08,
        "19"=>2.11,
        "24"=>2.2,
        "2"=>2.18,
        "15"=>2.21,
        "20"=>2.07,
        "14"=>2.22,
        "28"=>2.19,
        "4"=>2.04,
        "21"=>2.07,
        "25"=>2.22,
        "13"=>2.06,
        "18"=>2.15,
        "10"=>2.11,
        "29"=>2.17,
        "52"=>2.17,
        "54"=>2.34,
        "1"=>1.94,
        "23"=>1.97,
        "12"=>2.04,
        "27"=>2.02,
        "7"=>1.84,
        "22"=>2.05,
        "53"=>1.89
      }
    assert_equal expected, stat_tracker.average_team_scores
  end

  def test_average_home_team_scores
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expected = {
      "6"=>2.28,
      "3"=>2.1,
      "5"=>2.39,
      "16"=>2.23,
      "17"=>2.08,
      "8"=>2.08,
      "9"=>2.2,
      "30"=>2.22,
      "19"=>2.17,
      "26"=>2.14,
      "24"=>2.25,
      "2"=>2.28,
      "15"=>2.22,
      "20"=>2.2,
      "14"=>2.32,
      "28"=>2.24,
      "4"=>2.11,
      "21"=>2.22,
      "25"=>2.33,
      "13"=>2.16,
      "18"=>2.24,
      "10"=>2.26,
      "29"=>2.21,
      "52"=>2.3,
      "54"=>2.59,
      "1"=>1.97,
      "23"=>2.01,
      "27"=>2.2,
      "7"=>1.79,
      "22"=>2.06,
      "12"=>2.07,
      "53"=>1.93
    }

    assert_equal expected, stat_tracker.average_home_team_scores
  end

  def test_highest_score
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    average_visitor_scores = stat_tracker.average_visitor_scores
    assert_equal "FC Dallas", stat_tracker.highest_score(average_visitor_scores)
  end

  def test_it_gets_best_offense
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "Reign FC", stat_tracker.best_offense
  end

  def test_it_gets_worst_offense
    game_path = './data/games.csv'
      team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "Utah Royals FC", stat_tracker.worst_offense
  end

  def test_it_gets_highest_scoring_visitor
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "FC Dallas", stat_tracker.highest_scoring_visitor
  end

  def test_it_gets_highest_scoring_home_team
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "Reign FC", stat_tracker.highest_scoring_home_team
  end

  def test_lowest_score
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    average_visitor_scores = stat_tracker.average_visitor_scores
    assert_equal "San Jose Earthquakes", stat_tracker.lowest_score(average_visitor_scores)
  end

  def test_it_gets_lowest_scoring_visitor
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "San Jose Earthquakes", stat_tracker.lowest_scoring_visitor
  end

  def test_it_gets_lowest_scoring_home_team
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "Utah Royals FC", stat_tracker.lowest_scoring_home_team
  end

  def test_it_gets_team_info
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    assert_equal expected, stat_tracker.team_info("18")
  end

  def test_it_gets_best_season
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "20132014", stat_tracker.best_season("6")
  end

  def test_it_gets_worst_season
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "20142015", stat_tracker.worst_season("6")
  end

  def test_it_gets_average_win_percentage
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 0.49, stat_tracker.average_win_percentage("6")
  end

  def test_it_gets_most_goals_scored
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 7, stat_tracker.most_goals_scored("18")
  end

  def test_it_gets_fewest_goals_scored
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 0, stat_tracker.fewest_goals_scored("18")
  end

  def test_it_gets_favorite_opponent
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "DC United", stat_tracker.favorite_opponent("18")
  end

  def test_all_opponents_stats
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal 513, stat_tracker.all_opponents_stats("18").count
    all_opponent = stat_tracker.all_opponents_stats("18").none? do |stat|
      stat.team_id == "18"
    end
    assert_equal true, all_opponent
  end

  def test_win_percentage_against
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expected = {
      "19"=>0.44,
      "52"=>0.45,
      "21"=>0.38,
      "20"=>0.39,
      "17"=>0.64,
      "29"=>0.40,
      "25"=>0.37,
      "16"=>0.37,
      "30"=>0.41,
      "1"=>0.40,
      "8"=>0.30,
      "23"=>0.39,
      "3"=>0.30,
      "14"=>0.00,
      "15"=>0.50,
      "28"=>0.44,
      "22"=>0.22,
      "24"=>0.26,
      "5"=>0.56,
      "2"=>0.40,
      "26"=>0.44,
      "7"=>0.30,
      "27"=>0.33,
      "6"=>0.30,
      "13"=>0.6,
      "10"=>0.5,
      "9"=>0.20,
      "12"=>0.4,
      "54"=>0.33,
      "4"=>0.20,
      "53"=>0.25
    }
    assert_equal expected, stat_tracker.win_percentage_against("18")
  end

  def test_it_gets_rival
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expected = ["Houston Dash", "LA Galaxy"]
    assert_includes expected, stat_tracker.rival("18")
  end

  def test_it_gets_winningest_coach
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "Claude Julien", stat_tracker.winningest_coach("20132014")
    assert_equal "Alain Vigneault", stat_tracker.winningest_coach("20142015")
  end

  def test_it_gets_worst_coach
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "Peter Laviolette", stat_tracker.worst_coach("20132014")
    expected = ["Craig MacTavish", "Ted Nolan"]
    assert_includes expected, stat_tracker.worst_coach("20142015")
  end

  def test_it_gets_most_accurate_team
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "Real Salt Lake", stat_tracker.most_accurate_team("20132014")
    assert_equal "Toronto FC", stat_tracker.most_accurate_team("20142015")
  end

  def test_it_gets_least_accurate_team
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "New York City FC", stat_tracker.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", stat_tracker.least_accurate_team("20142015")
  end

  def test_it_gets_most_tackles
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "FC Cincinnati", stat_tracker.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", stat_tracker.most_tackles("20142015")
  end

  def test_it_gets_fewest_tackles
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "Atlanta United", stat_tracker.fewest_tackles("20132014")
    assert_equal "Orlando City SC", stat_tracker.fewest_tackles("20142015")
  end
end
