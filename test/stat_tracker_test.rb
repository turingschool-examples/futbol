require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def test_it_exists

    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'

    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_instance_of StatTracker, tracker
  end

  ####### Game Stats ########
  def test_highest_total_score_dummy_file
    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal 5, tracker.highest_total_score
  end

  def test_lowest_total_score_dummy_file
    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal 1, tracker.lowest_total_score
  end

  def test_percentage_home_wins_dummy_file
    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal 0.67, tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins_full_file
    game_path = './data/games.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal 0.36, tracker.percentage_visitor_wins
  end

  def test_percentage_ties_full_file
    game_path = './data/games.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal 0.2, tracker.percentage_ties
  end

  def test_count_of_games_by_season_full_file
    game_path = './data/games.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    expected = {
      "20122013"=>806, "20162017"=>1317, "20142015"=>1319,
      "20152016"=>1321, "20132014"=>1323, "20172018"=>1355
    }

    assert_equal Hash, tracker.count_of_games_by_season.class
    assert_equal expected, tracker.count_of_games_by_season
  end

  def test_average_goals_per_game_dummy_file
    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal Float, tracker.average_goals_per_game.class
    assert_equal 3.6, tracker.average_goals_per_game
  end

  def test_average_goals_by_season_full_file
    game_path = './data/games.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)
    tracker.count_of_games_by_season

    expected = {
                "20122013"=>4.12, "20162017"=>4.23,
                "20142015"=>4.14, "20152016"=>4.16,
                "20132014"=>4.19, "20172018"=>4.44
                }

    assert_equal Hash, tracker.average_goals_by_season.class
    assert_equal expected, tracker.average_goals_by_season
  end
  ###########################

  ###### Team Stats #########

  def test_team_info
    game_path = "./data/games.csv"
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    expected = {"team_id"=>"1", "franchise_id"=>"23", "team_name"=>"Atlanta United", "abbreviation"=>"ATL", "link"=>"/api/v1/teams/1"}

    assert_equal expected, tracker.team_info("1")
  end

  def test_best_season
    game_path = "./data/games.csv"
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal "20132014", tracker.best_season("6")
  end

  def test_worst_season
    game_path = "./data/games.csv"
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal  "20142015", tracker.worst_season("6")
  end
  def test_average_win_perentage
    game_path = "./data/games.csv"
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal 0.49, tracker.average_win_percentage("6")
  end

  def test_most_goals_scored
    game_path = "./data/games.csv"
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

  assert_equal 7, tracker.most_goals_scored("18")
  end

  def test_fewest_goals_scored
    game_path = "./data/games.csv"
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal 0, tracker.fewest_goals_scored("18")
  end

  # assert_equal "DC United", tracker.favorite_opponent("18")
  # assert_equal "Houston Dash", tracker.rival("18")

  ###########################

  ###### League Stats #######
  def test_count_of_teams_full_file
    game_path = './fixture/games_dummy15.csv'
    team_path = './data/teams.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal 32, tracker.count_of_teams
  end

  def test_best_offense_dummy_file
    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal "FC Dallas", tracker.best_offense
  end

  def test_worst_offense_dummy_file
    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal "Sporting Kansas City", tracker.worst_offense
  end

  def test_highest_scoring_visitor_full_file
    game_path = "./data/games.csv"
    team_path = './data/teams.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal 'FC Dallas', tracker.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor_full_file
    game_path = "./data/games.csv"
    team_path = './data/teams.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal 'San Jose Earthquakes', tracker.lowest_scoring_visitor
  end
  ###########################

  ###### Season Stats #######

  def test_most_tackles
    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    tracker.most_tackles("20122013")
    assert_equal "FC Dallas", tracker.most_tackles("20122013")
  end

  def test_fewest_tackles
    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal "Sporting Kansas City", tracker.fewest_tackles("20122013")
  end

  def test_most_accurate_team
    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal "FC Dallas", tracker.most_accurate_team("20122013")
    #unconfimred test
  end

  def test_least_accurate_team
    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal "Sporting Kansas City", tracker.least_accurate_team("20122013")
    #unconfimred test
  end

  def test_winningest_coach
    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal "Claude Julien", tracker.winningest_coach("20122013")
  end

  def test_worst_coach
    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal "John Tortorella", tracker.worst_coach("20122013")
  end

  def test_favorite_opponent
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_team_path = './data/game_teams.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal "DC United", tracker.favorite_opponent("18")
  end

  def test_rival
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_team_path = './data/game_teams.csv'
    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_equal "LA Galaxy", tracker.rival("18")
  end



end
