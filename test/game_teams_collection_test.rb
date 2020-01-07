require_relative 'testhelper'
require_relative '../lib/stat_tracker'

class GameTeamsCollectionTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.new("./test/fixtures/games_trunc.csv", "./test/fixtures/teams_trunc.csv", "./test/fixtures/game_teams_trunc.csv")
    @game_teams_collection = GameTeamsCollection.new(@stat_tracker.game_teams_path)
  end

  def test_it_exists
    assert_instance_of GameTeamsCollection, @game_teams_collection
    assert_equal Array, @game_teams_collection.game_teams.class
  end

  def test_it_creates_game_teams
    assert_instance_of GameTeam, @game_teams_collection.game_teams.first
    assert_equal "Claude Julien", @game_teams_collection.game_teams.first.head_coach
    assert_equal 4, @game_teams_collection.game_teams.first.goals
    assert_equal "away", @game_teams_collection.game_teams.first.hoa
  end

  def test_find_id_of_winningest_team
    assert_equal 6, @game_teams_collection.winningest_team_id
  end

  def test_find_id_of_team_with_best_fans
    assert_equal 3, @game_teams_collection.best_fans_team_id
  end

  def test_find_id_of_teams_with_worst_fans
    assert_equal [24, 5, 19], @game_teams_collection.worst_fans_team_id
  end

  def test_most_accurate_team
    first_game = @game_teams_collection.all_games_by_season("20122013").first
    last_game = @game_teams_collection.all_games_by_season("20122013").last
    season_2017 = @game_teams_collection.all_games_by_season("20172018")

    assert_equal "2012", first_game.game_id.to_s[0..3]
    assert_equal "2012", last_game.game_id.to_s[0..3]
    assert_equal 2, @game_teams_collection.most_accurate_team_id("20122013")
    assert_equal true, season_2017.all? {|game| game.game_id.to_s[0..3]}
  end

  def test_biggest_bust_id
    skip
    stat_tracker = StatTracker.new("./data/games.csv", "./data/teams.csv", "./data/game_teams.csv")
    game_teams_collection = GameTeamsCollection.new(stat_tracker.game_teams_path)

    assert_equal 23, @game_teams_collection.biggest_bust_id("20132014")
  end

  def test_biggest_surprise_id
    skip
    stat_tracker = StatTracker.new("./data/games.csv", "./data/teams.csv", "./data/game_teams.csv")
    game_teams_collection = GameTeamsCollection.new(stat_tracker.game_teams_path)

    assert_equal 26, @game_teams_collection.biggest_surprise_id("20132014")
  end

  def test_least_accurate_team
    assert_equal 15, @game_teams_collection.least_accurate_team_id("20122013")
    assert_equal 9, @game_teams_collection.least_accurate_team_id("20142015")
  end

  def test_all_games_by_season
    assert_equal 3, @game_teams_collection.all_games_by_season("20142015").length
  end

  def test_most_tackles_team_id
    assert_equal 9, @game_teams_collection.most_tackles_team_id("20142015")
  end

  def test_season_by_coach
    assert_equal 3, @game_teams_collection.season_by_coach("20142015").length
  end

  def test_coach_wins_losses
    assert_equal 3, @game_teams_collection.coach_wins_losses("20142015").length
  end

  def test_coach_percentage
    expected = {"Alain Vigneault"=>100.0, "Dave Cameron"=>0.0, "Joel Quenneville"=>0.0}
    assert_equal expected, @game_teams_collection.coach_percentage("20142015")
  end

  def test_worst_coach_name
    assert_equal "Dave Cameron", @game_teams_collection.worst_coach_name("20142015")
  end

  def test_winningest_coach_name
    assert_equal "Dave Cameron", @game_teams_collection.worst_coach_name("20142015")
  end

  def test_fewest_tackles_team_id
    assert_equal 16, @game_teams_collection.fewest_tackles_team_id("20142015")
  end

  def test_highest_scoring_visitor
    assert_equal 5, @game_teams_collection.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal 3, @game_teams_collection.lowest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal 6, @game_teams_collection.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal 9, @game_teams_collection.lowest_scoring_home_team
  end
end
