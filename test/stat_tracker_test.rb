require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
      games: './data/dummy_games.csv',
      teams: './data/dummy_teams.csv',
      game_teams: './data/dummy_game_teams.csv'
    }

    @stat_tracker = StatTracker.from_csv(@locations)
    require 'pry'; binding.pry
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_initialize
    assert_instance_of Team, @stat_tracker.teams[19]
    assert_equal 20, @stat_tracker.teams.length

    assert_instance_of Game, @stat_tracker.games[2012030221]
    assert_equal 20, @stat_tracker.games.length

    assert_instance_of GameTeam, @stat_tracker.game_teams[2012030221][0]
    assert_equal 2, @stat_tracker.game_teams[2012030221].length
    assert_equal 20, @stat_tracker.game_teams.length
  end



  ##### Game Statistics Tests #####

  def test_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 0.65, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.25, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.10, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {
      "20122013" => 4,
      "20132014" => 4,
      "20142015" => 4,
      "20152016" => 4,
      "20162017" => 4
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.20, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_per_season
    expected = {
      "20122013" => 5.0,
      "20132014" => 5.0,
      "20142015" => 3.0,
      "20152016" => 3.5,
      "20162017" => 4.5
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end



  ##### League Statistics Tests #####

  def test_winningest_team
    assert_equal "Seattle Sounders FC", @stat_tracker.winningest_team
  end

  def test_best_fans
    assert_equal "Seattle Sounders FC", @stat_tracker.best_fans
  end

  def test_worst_fans
    expected = ["Atlanta United", "New England Revolution", "Vancouver Whitecaps FC"]
    assert_equal expected, @stat_tracker.worst_fans.sort


    # assert_equal 3, @stat_tracker.worst_fans.length
    # assert_equal true, @stat_tracker.worst_fans.include?("New England Revolution")
    # assert_equal true, @stat_tracker.worst_fans.include?("Vancouver Whitecaps FC")
    # assert_equal true, @stat_tracker.worst_fans.include?("Atlanta United")
  end



  ##### Helper Method Tests #####

  def test_team_result_count
    expected = {
      3 =>{:games=>2, :total_goals=>4, :goals_allowed=>6, :away_goals=>4},
      6 =>{:games=>3, :total_goals=>8, :goals_allowed=>6, :home_goals=>6, :home_wins=>2, :away_goals=>2},
      13=>{:games=>3, :total_goals=>6, :goals_allowed=>8, :away_goals=>3, :home_goals=>3, :home_wins=>1},
      2 =>{:games=>2, :total_goals=>7, :goals_allowed=>3, :home_goals=>7, :home_wins=>2},
      19=>{:games=>5, :total_goals=>8, :goals_allowed=>13, :away_goals=>2, :home_goals=>6, :home_wins=>1},
      28=>{:games=>2, :total_goals=>5, :goals_allowed=>4, :home_goals=>3, :home_wins=>1, :away_goals=>2},
      16=>{:games=>2, :total_goals=>6, :goals_allowed=>4, :away_goals=>6, :away_wins=>2},
      27=>{:games=>1, :total_goals=>1, :goals_allowed=>4, :away_goals=>1},
      22=>{:games=>1, :total_goals=>2, :goals_allowed=>3, :away_goals=>2},
      30=>{:games=>3, :total_goals=>7, :goals_allowed=>3, :away_goals=>1, :home_goals=>6, :home_wins=>2},
      21=>{:games=>2, :total_goals=>4, :goals_allowed=>3, :home_goals=>2, :away_goals=>2, :away_wins=>1},
      1 =>{:games=>1, :total_goals=>2, :goals_allowed=>0, :away_goals=>2, :away_wins=>1},
      29=>{:games=>1, :total_goals=>0, :goals_allowed=>2, :home_goals=>0},
      4 =>{:games=>2, :total_goals=>2, :goals_allowed=>6, :away_goals=>1, :home_goals=>1},
      15=>{:games=>2, :total_goals=>6, :goals_allowed=>2, :home_goals=>2, :home_wins=>1, :away_goals=>4, :away_wins=>1},
      52=>{:games=>2, :total_goals=>2, :goals_allowed=>4, :home_goals=>1, :away_goals=>1},
      12=>{:games=>1, :total_goals=>2, :goals_allowed=>1, :home_goals=>2, :home_wins=>1},
      20=>{:games=>2, :total_goals=>4, :goals_allowed=>6, :away_goals=>4},
      24=>{:games=>2, :total_goals=>6, :goals_allowed=>4, :home_goals=>6, :home_wins=>2},
      10=>{:games=>1, :total_goals=>2, :goals_allowed=>2, :home_goals=>2}
    }
    assert_equal expected, @stat_tracker.team_result_count
  end


end



# Results from rspec

{
  3=>{:games=>531, :away_wins=>119, :home_wins=>111},
  7=>{:games=>458, :away_wins=>65,  :home_wins=>64}
}

{
  3=>{:games=>531, :away_wins=>119, :home_wins=>111, :away_ties=>43, :home_ties=>54, :away_losses=>104, :home_losses=>100},
  7=>{:games=>458, :away_wins=>65,  :home_wins=>64,  :away_ties=>46, :home_ties=>55, :away_losses=>118, :home_losses=>110}
}
