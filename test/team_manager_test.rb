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
      assert_instance_of TeamManager, @team_manager
    end

    def test_attributes
      assert_equal 32, @team_manager.team_data.length
    end

    def test_count_of_teams
      assert_equal 32, @team_manager.count_of_teams
    end

    def test_group_by_team_id
      assert_equal 32, @team_manager.group_by_team_id.keys.count
    end

    def test_team_id_and_average_goals
      assert_equal 32, @team_manager.team_id_and_average_goals.count
    end

    def test_best_offense_stats
      assert_equal 54, @team_manager.best_offense_stats
    end

    def test_worst_offense_stats
      assert_equal 7, @team_manager.worst_offense_stats
    end

    def test_team_with_best_offense
      assert_equal 'Reign FC', @team_manager.best_offense
    end

    def test_worst_offense
      assert_equal 'Utah Royals FC', @team_manager.worst_offense
    end

    def test_id_and_average_away_goals
      assert_equal 32, @team_manager.team_id_and_average_away_goals.count
    end

    def test_team_highest_away_goals
      assert_equal 6, @team_manager.team_highest_away_goals
    end

    def test_highest_scoring_visitor
      assert_equal 'FC Dallas', @team_manager.highest_scoring_visitor
    end

    def test_team_lowest_away_goals
      assert_equal 27, @team_manager.team_lowest_away_goals
    end

    def test_lowest_scoring_visitor
      assert_equal 'San Jose Earthquakes', @team_manager.lowest_scoring_visitor
    end

    def test_id_and_average_home_goals
      assert_equal 32, @team_manager.team_id_and_average_home_goals.count
    end

    def test_team_highest_home_goals
      assert_equal 54, @team_manager.team_highest_home_goals
    end

    def test_highest_scoring_home_team
      assert_equal 'Reign FC', @team_manager.highest_scoring_home_team
    end

    def test_team_lowest_home_goals
      assert_equal 7, @team_manager.team_lowest_home_goals
    end

    def test_lowest_scoring_home_team
      assert_equal 'Utah Royals FC', @team_manager.lowest_scoring_home_team
    end

    def test_in_can_find_team_info
      expected = {"team_id"=>"18",
                  "franchise_id"=>"34",
                  "team_name"=>"Minnesota United FC",
                  "abbreviation"=>"MIN",
                  "link"=>"/api/v1/teams/18"
      }
      assert_equal expected, @team_manager.team_info("18")
    end

    def test_all_team_games
      assert_equal 510, @team_manager.all_team_games("6").count
    end

    def test_it_can_group_by_season
      assert_equal 6, @team_manager.group_by_season("6").keys.count
    end

    def test_it_can_find_percent_wins_by_season
      expected = {"2012"=>0.543, "2017"=>0.532, "2013"=>0.574, "2014"=>0.378, "2015"=>0.402, "2016"=>0.511}

      assert_equal expected, @team_manager.percent_wins_by_season("6")
    end

    def test_it_can_find_best_season
      assert_equal "20132014", @team_manager.best_season("6")
    end

    def test_it_can_find_worst_season
      assert_equal "20142015", @team_manager.worst_season("6")
    end

    def test_it_can_find_total_wins
      assert_equal 251, @team_manager.total_wins("6").count
    end

    def test_it_can_find_avg_win_percentage
      assert_equal 0.49, @team_manager.average_win_percentage("6")
    end

    def test_it_can_find_most_goals_scored
      assert_equal 7, @team_manager.most_goals_scored("18")
    end

    def test_it_can_find_fewest_goals_scored
        assert_equal 0, @team_manager.fewest_goals_scored("18")
    end

    def test_it_can_find_all_game_ids_by_team
      assert_equal 513, @team_manager.find_all_game_ids_by_team("18").count
    end

    def test_it_can_find_opponent_id
      assert_equal 513, @team_manager.find_opponent_id("18").count
    end

    def test_it_can_make_a_hash_by_opponent_id
      assert_equal 31, @team_manager.hash_by_opponent_id("18").count
    end

    def test_it_can_sort_games_against_rival
      assert_equal 31, @team_manager.sort_games_against_rival("18").count
    end

    def test_it_can_find_count_of_games_against_rival
      assert_equal 31, @team_manager.find_count_of_games_against_rival("18").count
    end

    def test_it_can_find_favorite_opponent_id
      assert_equal "14", @team_manager.favorite_opponent_id("18")
    end

    def test_it_can_find_favorite
      assert_equal "DC United", @team_manager.favorite_opponent("18")
    end

    def test_it_can_find_rival_opponent_id
      assert_includes ["13", "17"], @team_manager.rival_opponent_id("18")
    end

    def test_it_can_find_rival
      assert_includes ["Houston Dash", "LA Galaxy"], @team_manager.rival("18")
    end
end
