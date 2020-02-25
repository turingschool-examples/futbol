require "./test/test_helper"
require './lib/stat_tracker'
require "./lib/game"
require "./lib/team"
require "./lib/game_team"


class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
                  games: "./data/games.csv", 
                  game_teams: "./data/game_teams.csv", 
                  teams: "./data/teams.csv" 
                }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def teardown
    Game.games = {}
    Team.teams = {}
    GameTeam.game_teams = {}
  end

  def test_it_exists
    assert_instance_of StatTracker, StatTracker.new
  end

  def test_from_csv_returns_new_instance
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_create_items
    StatTracker.create_items("./test/fixtures/teams_sample.csv", Team)

    assert_instance_of Team, Team.all[1]
  end

  def test_from_csv_loads_all_three_files
    skip
    assert_equal 100, Game.all.count
    assert_equal 50, GameTeam.all.count
    assert_equal 32, Team.all.count
  end

  def test_it_can_select_games_that_a_team_played
    skip
  end

  def test_it_can_calc_win_percentage
    games = [
              Game.new({home_team_id: 1, home_goals: 5, away_team_id: 2, away_goals: 1}),
              Game.new({home_team_id: 2, home_goals: 20, away_team_id: 1, away_goals: 5})
            ]
    team = Team.new({team_id: 1, teamname: "taco terrors"})
    @stat_tracker.win_percentage(games, team)
  end

  def test_it_knows_how_many_teams_there_are
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_knows_best_offense
    assert_equal "Reign FC", @stat_tracker.best_offense
  end
  def test_it_knows_worst_offense
    assert_equal  "Utah Royals FC", @stat_tracker.worst_offense
  end

  def test_it_knows_best_defense
    assert_equal "FC Cincinnati", @stat_tracker.best_defense
  end

  def test_it_knows_worst_defense
    assert_equal "Columbus Crew SC", @stat_tracker.worst_defense
  end

  def test_it_knows_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_it_knows_highest_scoring_home_team
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end

  def test_it_knows_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
  end

  def test_it_knows_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_knows_winningest_team
    assert_equal "Reign FC", @stat_tracker.winningest_team
  end

  def test_it_knows_best_fans
    assert_equal "San Jose Earthquakes", @stat_tracker.best_fans
  end

  def test_it_knows_worst_fans
    assert_equal ["Houston Dynamo", "Utah Royals FC"], @stat_tracker.worst_fans
  end

  def test_it_knows_winningest_coach
  assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
  assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
  end

  def test_it_knows_worst_coach
  assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
  assert_equal ("Craig MacTavish" || "Ted Nolan"), @stat_tracker.worst_coach("20142015")
  end

  def test_sort_module
    assert_equal [1,2,3,4,5,6,7,8], Game.find_all_scores(Game)
  end

  def test_highest_total_score
    assert_equal 8, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 0.54, @stat_tracker.percentage_home_wins
  end

  def test_percentage_away_wins
    assert_equal 0.43, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.03, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected =
    {
      "20122013" => 57,
      "20162017" => 4,
      "20142015" => 17,
      "20152016" => 16,
      "20132014" => 6
    }

    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 3.95, @stat_tracker.average_goals_per_game
  end

  def test_total_goals_per_season
    game = Game.all.values.first

    assert_equal 220, @stat_tracker.total_goals_per_season(game.season)
  end

  def test_average_goals_by_season
    expected =
    {
      "20122013" => 3.86,
      "20162017" => 4.75,
      "20142015" => 4.00,
      "20152016" => 3.88,
      "20132014" => 4.33
    }

    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_return_team_name
    tackles = mock("tackles")
    tackles.stubs(:accumulator).returns({3 => 10, 10 => 1})

    assert_equal "Houston Dynamo", @stat_tracker.return_team_name(tackles.accumulator)
  end

  def test_most_tackles
    game = Game.all.values.first

    assert_equal "Houston Dynamo", @stat_tracker.most_tackles(game.season)
  end

  def test_fewest_tackles
    game = Game.all.values.first

    assert_equal "Orlando City SC", @stat_tracker.fewest_tackles(game.season)
  end

  def test_games_in_season
    game = Game.all.values.first

    assert_equal 57, Game.games_in_a_season(game.season).length
  end

  def test_most_accurate_team
    game = Game.all.values.first

    assert_equal "New York City FC", @stat_tracker.most_accurate_team(game.season)
  end

  def test_least_accurate_team
    game = Game.all.values.first

    assert_equal "Houston Dynamo", @stat_tracker.least_accurate_team(game.season)
  end

end
