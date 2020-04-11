require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/game_teams'
require './lib/team'
require './lib/game'
require './lib/stat_tracker'


class StatTrackerTest < Minitest::Test

  # locations = {
  #   games: game_path,
  #   teams: team_path,
  #   game_teams: game_teams_path
  # }
  #
  # def setup
  #     @stat_tracker = StatTracker.from_csv({
  #       :teams     => "./data/teams.csv",
  #       :games => "./data/games.csv",
  #       :game_teams => "./data/game_teams.csv"
  #     })
  #   end
      def setup
        @stat_tracker = StatTracker.from_csv({
          :teams     => ("./data/teams.csv"),
          :games => ("./data/games.csv"),
          :game_teams => ("./data/game_teams.csv")
        })
      end



  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end
  #
  def test_it_has_attributes

       # require"pry";binding.pry
     assert_equal 2012030221, @stat_tracker.game_repository.games_collection[0].game_id
    assert_equal 23, @stat_tracker.team_repository.teams_collection[0].franchiseid
    assert_equal 2012030221, @stat_tracker.game_team_repository.game_teams_collection[0].game_id
  end

  def test_highest_total_score

    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_percentage_home_wins
    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end

  def test_it_can_report_most_goals_scored
    assert_equal 7, @stat_tracker.most_goals_scored("18")
  end

  def test_it_can_report_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored("6")
  end

  def test_best_offense
    assert_equal "Sporting Kansas City", @stat_tracker.best_offense
  end

  def test_percentage_visitor_wins

  end

  def test_percentage_ties

  end

  def test_count_of_games_by_season

  end

  def test_average_goals_per_game

  end

  def test_average_goals_by_season

  end

  def test_worst_offense
    assert_equal "Reign FC", @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "Sporting Kansas City", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Sporting Kansas City", @stat_tracker.highest_scoring_home
  end

  def test_lowest_scoring_visitor
    assert_equal "Reign FC", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Reign FC", @stat_tracker.lowest_scoring_home
  end

  def test_team_info

  end

  def test_best_season

  end

  def test_worst_season

  end

  def test_average_win_percentage

  end

  def test_favorite_opponent

  end

  def test_rival

  end

  def test_winningest_coach

  end

  def test_worst_coach

  end

  def test_most_accurate_team

  end

  def test_least_accurate_team

  end

  def test_most_tackles

  end

  def test_fewest_tackles

  end

  #
  # def test_it_has_teams
  # expected = "Atlanta United"
  #
  #   assert_equal expected, @stat_tracker.team_path[0].teamname
  # end
  #
  # def test_it_has_games
  #   assert_equal 2012030222, @stat_tracker.game_path[1].game_id
  # end
  #
  # def test_it_has_game_stats
  #    # require "pry";binding.pry
  #   assert_equal 2012030222, @stat_tracker.game_teams_path[2].game_id
  # end
  #
  # def test_it_has_info
  #
  #   expected = {:team_id=>3, :franchise_id=>10, :team_name=>"Houston Dynamo", :abbreviation=>"HOU", :link=>"/api/v1/teams/3"}
  #   assert_equal expected, @stat_tracker.team_info(3)
  # end
  #
  # def test_best_season
  #
  #
  #
  #   expected = "20152016"
  #   assert_equal expected, @stat_tracker.best_season(1)
  # end
  #
  # def test_games_per_season
  #
  #   expected = 87
  #   assert_equal expected, @stat_tracker.games_per_season(3, "20152016")
  # end
  #
  # def test_teams_worst_season
  #
  #   expected = "20132014"
  #   assert_equal expected, @stat_tracker.worst_season(2)
  # end
  #
  # # def test_average_win_percentage
  # #   @stat_tracker.game_stats(@stat_tracker.game_teams_path)
  # #   expected = 0.0
  # #   assert_equal expected, @stat_tracker.average_win_percentage(5)
  # #
  # # end
  #
  # def test_total_games_played
  #
  #
  # end
  #
  # def test_highest_total_score
  #
  #   expected = 0
  #   assert_equal expected, @stat_tracker.highest_total_score(all_games)
  #
  # end
end
