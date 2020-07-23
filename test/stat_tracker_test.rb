
require "./test/test_helper.rb"
require './lib/stat_tracker'

class StatTrackerTest < MiniTest::Test


  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_can_count_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_best_offense_team
    assert_equal "Reign FC", @stat_tracker.best_offense

  end

  def test_it_can_worst_offense_team
    skip
    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
  end

  def test_it_can_get_highest_scoring_vistor_team
    skip
    assert_equal "FC Dallas", @stat_tracker.highest_visitor_team
  end

  def test_it_can_get_highest_scoring_home_team
    skip
    assert_equal "Reign FC", @stat_tracker.highest_home_team
  end

  def test_it_can_get_lowest_scoring_visitor_team
    skip
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_visitor_team


  def test_highest_scores
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_lowest_scores
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_percentage_home_wins
    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.36, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    skip
    assert_equal 0.20, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
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

<<<<<<< HEAD
  def test_it_can_display_best_season
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal "20132014", stats.best_season(6)

  end

  def test_it_can_display_worst_season
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal "20142015", stats.worst_season(6)
  end

  def test_it_can_display_average_win_percentage
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal 0.49, stats.average_win_percentage(6)
  end

  def test_it_can_display_most_goals_scored
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal "7", stats.most_goals_scored(18)
  end

  def test_it_can_display_fewest_goals_scored
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal "0", stats.fewest_goals_scored(18)
  end

  def test_it_can_display_favorite_opponent
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal "DC United", stats.favorite_opponent(18)
  end

  def test_it_can_display_rival
    skip
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stats = StatTracker.from_csv(locations)
    assert_equal "LA Galaxy", stats.rival(18)
  end

=======
  def test_it_can_get_lowest_scoring_home_team
    skip
    assert_equal "Utah Royals FC", @stat_tracker.lowest_home_team
  end
>>>>>>> 0956c1bba355c9acf379c7070f33ebd491e38f8f
end
