require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'
require './lib/game_teams_manager'

class GameTeamsManagerTest < Minitest::Test
  def setup
    @game_path = './fixture/games_dummy.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './fixture/game_teams_dummy.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of GameTeamsManager, @stat_tracker.game_teams_manager
  end

  def test_find_team_results_by_season
    game_path = './fixture/game_blank.csv'
    team_path = './fixture/team_blank.csv'
    game_teams_path = './fixture/game_teams_blank.csv'

    tracker = StatTracker.new(game_path, team_path, game_teams_path)
    game_1 = mock("Season Game 1")
    game_2 = mock("Season Game 2")
    game_3 = mock("Season Game 3")
    tracker.game_manager.games << game_1
    tracker.game_manager.games << game_2
    tracker.game_manager.games << game_3

    game_teams_1 = mock("Game Team Object 1")
    game_teams_2 = mock("Game Team Object 2")
    game_teams_3 = mock("Game Team Object 3")
    tracker.game_teams_manager.game_teams << game_teams_1
    tracker.game_teams_manager.game_teams << game_teams_2
    tracker.game_teams_manager.game_teams << game_teams_3

    game_1.stubs(:season).returns('20122013')
    game_2.stubs(:season).returns('20122013')
    game_3.stubs(:season).returns('20132014')
    game_1.stubs(:game_id).returns('123')
    game_2.stubs(:game_id).returns('456')
    game_3.stubs(:game_id).returns('789')
    game_teams_1.stubs(:game_id).returns('123')
    game_teams_2.stubs(:game_id).returns('987')
    game_teams_3.stubs(:game_id).returns('555')

    assert_equal [game_teams_1], tracker.game_teams_manager.game_teams_results_by_season('20122013')
  end

  def test_initialize_coaches_records
    results = @stat_tracker.game_teams_manager.game_teams_results_by_season('20122013')
    expected = {"John Tortorella"=>{:wins=>0, :losses=>0, :ties=>0},
              "Claude Julien"=>{:wins=>0, :losses=>0, :ties=>0}, "Dan Bylsma"=>{:wins=>0, :losses=>0, :ties=>0},
              "Mike Babcock"=>{:wins=>0, :losses=>0, :ties=>0}, "Joel Quenneville"=>{:wins=>0, :losses=>0, :ties=>0}}
    assert_equal expected, @stat_tracker.game_teams_manager.initialize_coaches_records(results)
  end

  def test_add_wins_losses
    results = @stat_tracker.game_teams_manager.game_teams_results_by_season('20122013')
    coach_record_start = @stat_tracker.game_teams_manager.initialize_coaches_records(results)
    expected = {"John Tortorella"=>{:wins=>0, :losses=>5, :ties=>0}, "Claude Julien"=>{:wins=>9, :losses=>0, :ties=>0},
                "Dan Bylsma"=>{:wins=>0, :losses=>4, :ties=>0}, "Mike Babcock"=>{:wins=>4, :losses=>3, :ties=>0},
                "Joel Quenneville"=>{:wins=>3, :losses=>4, :ties=>0}}
    assert_equal expected, @stat_tracker.game_teams_manager.add_wins_losses(results, coach_record_start)
  end

  def test_winningest_coach
    results = @stat_tracker.game_teams_manager.game_teams_results_by_season('20122013')
    coach_record_start = @stat_tracker.game_teams_manager.initialize_coaches_records(results)
    total_record = @stat_tracker.game_teams_manager.add_wins_losses(results, coach_record_start)
    assert_equal "Claude Julien", @stat_tracker.game_teams_manager.winningest_coach('20122013')
  end

  def test_worst_coach
    results = @stat_tracker.game_teams_manager.game_teams_results_by_season('20122013')
    coach_record_start = @stat_tracker.game_teams_manager.initialize_coaches_records(results)
    total_record = @stat_tracker.game_teams_manager.add_wins_losses(results, coach_record_start)
    assert_equal "John Tortorella", @stat_tracker.game_teams_manager.worst_coach('20122013')
  end

  def test_initialize_shots_and_goals_per_team
    results = @stat_tracker.game_teams_manager.game_teams_results_by_season('20122013')
    expected = {"3"=>{:shots=>0, :goals=>0}, "6"=>{:shots=>0, :goals=>0}, "5"=>{:shots=>0, :goals=>0},
                "17"=>{:shots=>0, :goals=>0}, "16"=>{:shots=>0, :goals=>0}}
    assert_equal expected, @stat_tracker.game_teams_manager.initialize_shots_and_goals_per_team(results)
  end

  def test_add_shots_and_goals
    results = @stat_tracker.game_teams_manager.game_teams_results_by_season('20122013')
    teams_shots_to_goals_start = @stat_tracker.game_teams_manager.initialize_shots_and_goals_per_team(results)
    expected = {"3"=>{:shots=>38, :goals=>8}, "6"=>{:shots=>76, :goals=>24}, "5"=>{:shots=>32, :goals=>2},
                "17"=>{:shots=>46, :goals=>13}, "16"=>{:shots=>58, :goals=>10}}
    assert_equal expected, @stat_tracker.game_teams_manager.add_shots_and_goals(results, teams_shots_to_goals_start)
  end

  def test_most_accurate_team
    results = @stat_tracker.game_teams_manager.game_teams_results_by_season('20122013')
    teams_shots_to_goals_start = @stat_tracker.game_teams_manager.initialize_shots_and_goals_per_team(results)
    total_shot_goals_record = @stat_tracker.game_teams_manager.add_shots_and_goals(results, teams_shots_to_goals_start)
    assert_equal "FC Dallas", @stat_tracker.game_teams_manager.most_accurate_team('20122013')
  end

  def test_least_accurate_team
    results = @stat_tracker.game_teams_manager.game_teams_results_by_season('20122013')
    teams_shots_to_goals_start = @stat_tracker.game_teams_manager.initialize_shots_and_goals_per_team(results)
    total_shot_goals_record = @stat_tracker.game_teams_manager.add_shots_and_goals(results, teams_shots_to_goals_start)
    assert_equal "Sporting Kansas City", @stat_tracker.game_teams_manager.least_accurate_team('20122013')
  end

  def test_initialize_tackles_per_team
    results = @stat_tracker.game_teams_manager.game_teams_results_by_season('20122013')
    expected = {"3"=>0, "6"=>0, "5"=>0, "17"=>0, "16"=>0}
    assert_equal expected, @stat_tracker.game_teams_manager.initialize_tackles_per_team(results)
  end

  def test_add_tackles
    results = @stat_tracker.game_teams_manager.game_teams_results_by_season('20122013')
    tackles_start = @stat_tracker.game_teams_manager.initialize_tackles_per_team(results)
    expected = {"3"=>179, "6"=>271, "5"=>150, "17"=>219, "16"=>178}
    assert_equal expected, @stat_tracker.game_teams_manager.add_tackles(results, tackles_start)
  end

  def test_team_with_most_tackles
    results = @stat_tracker.game_teams_manager.game_teams_results_by_season('20122013')
    tackles_start = @stat_tracker.game_teams_manager.initialize_tackles_per_team(results)
    added_tackles = @stat_tracker.game_teams_manager.add_tackles(results, tackles_start)
    assert_equal "FC Dallas", @stat_tracker.game_teams_manager.most_tackles('20122013')
  end

  def test_team_with_fewest_tackles
    results = @stat_tracker.game_teams_manager.game_teams_results_by_season('20122013')
    tackles_start = @stat_tracker.game_teams_manager.initialize_tackles_per_team(results)
    added_tackles = @stat_tracker.game_teams_manager.add_tackles(results, tackles_start)
    assert_equal "Sporting Kansas City", @stat_tracker.game_teams_manager.fewest_tackles('20122013')
  end
end
