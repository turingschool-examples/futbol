require_relative 'test_helper'

class TeamManagerTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
  @stat_tracker = StatTracker.from_csv(locations)
  @team_manager = TeamManager.new('./data/teams.csv', @stat_tracker)
  end

  def test_it_exits
      assert_instance_of TeamManager, @team_stats
    end

    def test_attributes
      assert_equal 32, @team_stats.teams_data.length
    end

    def test_count_of_teams
      assert_equal 32, @team_stats.count_of_teams
    end
    # 
    # def test_group_by_team_id
    #   assert_equal 32, @team_stats.group_by_team_id.keys.count
    # end
    #
    # def test_team_id_and_average_goals
    #   assert_equal 32, @team_stats.team_id_and_average_goals.count
    # end
    #
    # def test_best_offense_stats
    #   assert_equal 54, @team_stats.best_offense_stats
    # end
    #
    # def test_worst_offense_stats
    #   assert_equal 7, @team_stats.worst_offense_stats
    # end
    #
    # def test_team_with_best_offense
    #   assert_equal 'Reign FC', @team_stats.best_offense
    # end
    #
    # def test_worst_offense
    #   assert_equal 'Utah Royals FC', @team_stats.worst_offense
    # end
    #
    # def test_id_and_average_away_goals
    #   assert_equal 32, @team_stats.team_id_and_average_away_goals.count
    # end
    #
    # def test_team_highest_away_goals
    #   assert_equal 6, @team_stats.team_highest_away_goals
    # end
    #
    # def test_highest_scoring_visitor
    #   assert_equal 'FC Dallas', @team_stats.highest_scoring_visitor
    # end
    #
    # def test_team_lowest_away_goals
    #   assert_equal 27, @team_stats.team_lowest_away_goals
    # end
    #
    # def test_lowest_scoring_visitor
    #   assert_equal 'San Jose Earthquakes', @team_stats.lowest_scoring_visitor
    # end
    #
    # def test_id_and_average_home_goals
    #   assert_equal 32, @team_stats.team_id_and_average_home_goals.count
    # end
    #
    # def test_team_highest_home_goals
    #   assert_equal 54, @team_stats.team_highest_home_goals
    # end
    #
    # def test_highest_scoring_home_team
    #   assert_equal 'Reign FC', @team_stats.highest_scoring_home_team
    # end
    #
    # def test_team_lowest_home_goals
    #   assert_equal 7, @team_stats.team_lowest_home_goals
    # end
    #
    # def test_lowest_scoring_home_team
    #   assert_equal 'Utah Royals FC', @team_stats.lowest_scoring_home_team
    # end
end
