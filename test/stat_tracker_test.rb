require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

    class StatTrackerTest < Minitest::Test

    def setup
        game_path = './data/games.csv'
        team_path = './data/teams.csv'
        game_teams_path = './data/game_teams.csv'
        dummy_path = './data/dummy.csv'

        locations = {
            games: game_path,
            teams: team_path,
            game_teams: game_teams_path,
            dummy: dummy_path
        }

        @stat_tracker = StatTracker.from_csv(locations)
    end


    def test_it_exisits_and_has_attributes
        assert_instance_of StatTracker, @stat_tracker
    end

    def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
    end

    def test_best_offense
    skip
    assert_equal "Reign FC", @stat_tracker.best_offense
    end

    def test_worst_offense
    skip
    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
    end

    def test_highest_scoring_visitor
    skip
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
    end

    def test_highest_scoring_team
    skip
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
    end

    def test_lowest_scoring_visitor
    skip
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
    end

    def test_lowest_scoring_home_team
        skip
        assert_equal "Utah Royals FC", @stat_tracker.lowest_scoring_home_team
    end

    def test_highest_total_score
    expected = 11
    assert_equal expected, @stat_tracker.highest_total_score
    end

    def test_lowest_total_score
    expected = 0
    assert_equal expected, @stat_tracker.lowest_total_score
    end

    def test_percentage_home_wins
      skip
    expect(@stat_tracker.percentage_home_wins).to eq 0.44
    end

    def test_percentage_visitor_wins
      skip
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
    end

    def test_percentage_ties
      skip
    expect(@stat_tracker.percentage_ties).to eq 0.20
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
    expect(@stat_tracker.count_of_games_by_season).to eq expected
    end

    def test_average_goals_per_game
      skip
    expect(@stat_tracker.average_goals_per_game).to eq 4.22
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
    expect(@stat_tracker.average_goals_by_season).to eq expected
    end
  end
