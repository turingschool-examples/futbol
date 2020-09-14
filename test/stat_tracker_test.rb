require_relative 'test_helper'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    @stat_tracker ||= StatTracker.new({games: game_path, teams: team_path,
      game_teams: game_teams_path})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_from_csv
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_games_has_game_data
    stat = StatTracker.new
    assert_equal false, stat.game_table.include?("2012030221")
    assert @stat_tracker.game_table.include?("2017030317")
    assert @stat_tracker.game_table.include?("2012030213")
  end

  def test_teams_has_game_data
    stat = StatTracker.new
    assert_equal false, stat.team_table.include?("4")
    assert @stat_tracker.team_table.include?("26")
    assert @stat_tracker.team_table.include?("14")
  end

  def test_game_teams_has_game_data
    stat = StatTracker.new
    assert_equal false, stat.game_team_table.include?("2012030221")
    @stat_tracker.game_team_table.find do |game|
    assert_equal true, game.game_id == 2012030221
    end
  end

  def test_team_info
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :team_info, mocked_method do
      @stat_tracker.team_info
    end
  end

  def test_best_season
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :best_season, mocked_method do
      @stat_tracker.best_season
    end
  end

  def test_worst_season
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :worst_season, mocked_method do
      @stat_tracker.worst_season
    end
  end

  def test_average_win_percentage
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :average_win_percentage, mocked_method do
      @stat_tracker.average_win_percentage
    end
  end

  def test_most_goals_scored
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :most_goals_scored, mocked_method do
      @stat_tracker.most_goals_scored
    end
  end

  def test_fewest_goals_scored
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :fewest_goals_scored, mocked_method do
      @stat_tracker.fewest_goals_scored
    end
  end

  def test_favorite_opponent
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :favorite_opponent, mocked_method do
      @stat_tracker.favorite_opponent
    end
  end

  def test_rival
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :rival, mocked_method do
      @stat_tracker.rival
    end
  end

  def test_highest_total_score
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :highest_total_score, mocked_method do
      @stat_tracker.highest_total_score
    end
  end

  def test_lowest_total_score
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :lowest_total_score, mocked_method do
      @stat_tracker.lowest_total_score
    end
  end

  def test_percentage_home_wins
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :percentage_home_wins, mocked_method do
      @stat_tracker.percentage_home_wins
    end
  end

  def test_percentage_visitor_wins
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :percentage_visitor_wins, mocked_method do
      @stat_tracker.percentage_visitor_wins
    end
  end

  def test_percentage_ties
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :percentage_ties, mocked_method do
      @stat_tracker.percentage_ties
    end
  end

  def test_count_of_games_by_season
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :count_of_games_by_season, mocked_method do
      @stat_tracker.count_of_games_by_season
    end
  end

  def test_average_goals_per_game
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :average_goals_per_game, mocked_method do
      @stat_tracker.average_goals_per_game
    end
  end

  def test_average_goals_by_season
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :average_goals_by_season, mocked_method do
      @stat_tracker.average_goals_by_season
    end
  end

  def test_count_of_teams
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :count_of_teams, mocked_method do
      @stat_tracker.count_of_teams
    end
  end

  def test_best_offense
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :best_offense, mocked_method do
      @stat_tracker.best_offense
    end
  end

  def test_worst_offense
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :worst_offense, mocked_method do
      @stat_tracker.worst_offense
    end
  end

  def test_highest_scoring_visitor
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :highest_scoring_visitor, mocked_method do
      @stat_tracker.highest_scoring_visitor
    end
  end

  def test_highest_scoring_home_team
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :highest_scoring_home_team, mocked_method do
      @stat_tracker.highest_scoring_home_team
    end
  end

  def test_lowest_scoring_visitor
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :lowest_scoring_visitor, mocked_method do
      @stat_tracker.lowest_scoring_visitor
    end
  end

  def test_lowest_scoring_home_team
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :lowest_scoring_home_team, mocked_method do
      @stat_tracker.lowest_scoring_home_team
    end
  end

  def test_winningest_coach
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :winningest_coach, mocked_method do
      @stat_tracker.winningest_coach
    end
  end

  def test_worst_coach
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :worst_coach, mocked_method do
      @stat_tracker.worst_coach
    end
  end

  def test_most_accurate_team
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :most_accurate_team, mocked_method do
      @stat_tracker.most_accurate_team
    end
  end

  def test_least_accurate_team
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :least_accurate_team, mocked_method do
      @stat_tracker.least_accurate_team
    end
  end

  def test_most_tackles
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :most_tackles, mocked_method do
      @stat_tracker.most_tackles
    end
  end

  def test_fewest_tackles
    mocked_method = MiniTest::Mock.new
    mocked_method.expect(:call,nil)
    @stat_tracker.stub :fewest_tackles, mocked_method do
      @stat_tracker.fewest_tackles
    end
  end
end
