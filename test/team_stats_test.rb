require_relative 'test_helper'
require "./lib/game_statistics"
require "./lib/team_stats"
require './lib/stat_tracker'
require './lib/season_stats'

class TeamStatsTest < Minitest::Test
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
    @raw_game_stats = @stat_tracker.game_stats
    @raw_game_teams_stats = @stat_tracker.game_teams_stats
    @raw_team_stats = @stat_tracker.teams_stats
    @season_stats = SeasonStatistics.new(@raw_game_stats, @raw_game_teams_stats, @raw_team_stats)
    @team_stats = TeamStats.new(@season_stats)
  end

  # def test_it_exists
  #   assert_instance_of TeamStats, @team_stats
  # end
  #
  # def test_in_can_find_team_info
  #   expected = {"team_id"=>"18",
  #               "franchiseid"=>"34",
  #               "teamname"=>"Minnesota United FC",
  #               "abbreviation"=>"MIN",
  #               "link"=>"/api/v1/teams/18"
  #   }
  #   assert_equal expected, @team_stats.team_info("18")
  # end
  #
  # def test_all_team_games
  #   assert_equal 510, @team_stats.all_team_games("6").count
  # end
  #
  # def test_it_can_group_by_season
  #   assert_equal 6, @team_stats.group_by_season("6").keys.count
  # end
  #
  # def test_it_can_find_percent_wins_by_season
  #   expected = {"2012"=>0.543, "2017"=>0.532, "2013"=>0.574, "2014"=>0.378, "2015"=>0.402, "2016"=>0.511}
  #
  #   assert_equal expected, @team_stats.percent_wins_by_season("6")
  # end
  #
  # def test_it_can_find_best_season
  #   assert_equal "20132014", @team_stats.best_season("6")
  # end

  def test_it_can_find_worst_season
    assert_equal "20142015", @team_stats.worst_season("6")
  end
end
