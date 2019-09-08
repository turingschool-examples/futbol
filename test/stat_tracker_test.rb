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
    #require 'pry'; binding.pry
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_initialize
    assert_instance_of Team, @stat_tracker.teams[19]
    assert_equal 20, @stat_tracker.teams.length

    assert_instance_of Game, @stat_tracker.games[2012030221]
    assert_equal 31, @stat_tracker.games.length

    assert_instance_of GameTeam, @stat_tracker.game_teams[2012030221][0]
    assert_equal 2, @stat_tracker.game_teams[2012030221].length
    assert_equal 31, @stat_tracker.game_teams.length
  end



  ##### Game Statistics Tests #####

  def test_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 0.61, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.23, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.16, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {
      "20122013" => 7,
      "20132014" => 7,
      "20142015" => 5,
      "20152016" => 5,
      "20162017" => 6,
      "20172018" => 1,
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.19, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_per_season
    expected = {
      "20122013" => 4.86,
      "20132014" => 4.29,
      "20142015" => 2.8,
      "20152016" => 3.4,
      "20162017" => 4.83,
      "20172018" => 6.0
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end



  ##### League Statistics Tests #####

  def test_method_count_of_teams
    assert_equal 20, @stat_tracker.count_of_teams
  end

  def test_method_best_offense
    assert_equal "Portland Timbers", @stat_tracker.best_offense
  end

  def test_method_worst_offense
    assert_equal "Portland Thorns FC", @stat_tracker.worst_offense
  end

  def test_best_defense
    assert_equal "Atlanta United", @stat_tracker.best_defense
  end

  def test_worst_defense
    assert_equal "San Jose Earthquakes", @stat_tracker.worst_defense
  end

  def test_highest_scoring_visitor
    assert_equal "Portland Timbers", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Orlando City SC", @stat_tracker.highest_scoring_home_team
  end

  # def test_lowest_scoring_visitor
  #   assert_equal "North Carolina Courage", @stat_tracker.lowest_scoring_visitor
  # end
  #
  # def lowest_scoring_home_team
  #   assert_equal "", @stat_tracker.lowest_scoring_home_team
  # end

  def test_winningest_team
    assert_equal "New England Revolution", @stat_tracker.winningest_team
  end

  def test_best_fans
    assert_equal "Orlando City SC", @stat_tracker.best_fans
  end

  def test_worst_fans
    expected = ["Atlanta United", "Vancouver Whitecaps FC"]
    assert_equal expected, @stat_tracker.worst_fans.sort
    # assert_equal 3, @stat_tracker.worst_fans.length
    # assert_equal true, @stat_tracker.worst_fans.include?("New England Revolution")
    # assert_equal true, @stat_tracker.worst_fans.include?("Vancouver Whitecaps FC")
    # assert_equal true, @stat_tracker.worst_fans.include?("Atlanta United")
  end





  ##### Helper Method Tests #####

  def test_team_result_count
    expected = {3=>{:games=>3, :total_goals=>6, :goals_allowed=>7, :away_goals=>4, :away_games=>2, :home_goals=>2, :home_games=>1, :home_wins=>1}, 6=>{:games=>5, :total_goals=>12, :goals_allowed=>9, :home_goals=>8, :home_games=>3, :home_wins=>3, :away_goals=>4, :away_games=>2}, 13=>{:games=>4, :total_goals=>7, :goals_allowed=>10, :away_goals=>4, :away_games=>3, :home_goals=>3, :home_games=>1, :home_wins=>1}, 2=>{:games=>4, :total_goals=>11, :goals_allowed=>9, :home_goals=>9, :home_games=>3, :home_wins=>2, :away_goals=>2, :away_games=>1}, 19=>{:games=>5, :total_goals=>8, :goals_allowed=>13, :away_goals=>2, :away_games=>2, :home_goals=>6, :home_games=>3, :home_wins=>1}, 28=>{:games=>2, :total_goals=>5, :goals_allowed=>4, :home_goals=>3, :home_games=>1, :home_wins=>1, :away_goals=>2, :away_games=>1}, 16=>{:games=>3, :total_goals=>8, :goals_allowed=>4, :away_goals=>6, :away_games=>2, :away_wins=>2, :home_goals=>2, :home_games=>1, :home_wins=>1}, 27=>{:games=>2, :total_goals=>4, :goals_allowed=>7, :away_goals=>1, :away_games=>1, :home_goals=>3, :home_games=>1}, 22=>{:games=>2, :total_goals=>4, :goals_allowed=>4, :away_goals=>2, :away_games=>1, :home_goals=>2, :home_games=>1, :home_wins=>1}, 30=>{:games=>4, :total_goals=>11, :goals_allowed=>5, :away_goals=>1, :away_games=>1, :home_goals=>10, :home_games=>3, :home_wins=>3}, 21=>{:games=>2, :total_goals=>4, :goals_allowed=>3, :home_goals=>2, :home_games=>1, :away_goals=>2, :away_games=>1, :away_wins=>1}, 1=>{:games=>2, :total_goals=>4, :goals_allowed=>2, :away_goals=>2, :away_games=>1, :away_wins=>1, :home_goals=>2, :home_games=>1}, 29=>{:games=>3, :total_goals=>5, :goals_allowed=>7, :home_goals=>0, :home_games=>1, :away_goals=>5, :away_games=>2}, 4=>{:games=>5, :total_goals=>8, :goals_allowed=>13, :away_goals=>2, :away_games=>2, :home_goals=>6, :home_games=>3, :home_wins=>1}, 15=>{:games=>2, :total_goals=>6, :goals_allowed=>2, :home_goals=>2, :home_games=>1, :home_wins=>1, :away_goals=>4, :away_games=>1, :away_wins=>1}, 52=>{:games=>2, :total_goals=>2, :goals_allowed=>4, :home_goals=>1, :home_games=>1, :away_goals=>1, :away_games=>1}, 12=>{:games=>2, :total_goals=>5, :goals_allowed=>5, :home_goals=>2, :home_games=>1, :home_wins=>1, :away_goals=>3, :away_games=>1}, 20=>{:games=>3, :total_goals=>6, :goals_allowed=>9, :away_goals=>4, :away_games=>2, :home_goals=>2, :home_games=>1}, 24=>{:games=>4, :total_goals=>11, :goals_allowed=>7, :home_goals=>6, :home_games=>2, :home_wins=>2, :away_goals=>5, :away_games=>2, :away_wins=>2}, 10=>{:games=>3, :total_goals=>3, :goals_allowed=>6, :home_goals=>2, :home_games=>1, :away_goals=>1, :away_games=>2}}

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
