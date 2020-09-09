require_relative 'test_helper'

class TeamStatisticsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'

    @stat ||= StatTracker.new({games: game_path, teams: team_path})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat
  end

  def test_team_info
    expected = {    "team_id" => "18",
                    "franchise_id" => "34",
                    "team_name" => "Minnesota United FC",
                    "abbreviation" => "MIN",
                    "link" => "/api/v1/teams/18"
                  }
    assert_equal expected, @stat.team_info("18")
    @stat.collect_seasons("1")
  end

  # def test_collect_seasons
  #   assert_equal 2015020086, @stat.collect_seasons("18")["20152016"][0].game_id
  #   assert_equal "Allianz Field", @stat.collect_seasons("18")["20152016"][0].venue
    # actual_2 = @stat.collect_seasons("18")["20152016"].include?(2015020086)
    # actual = actual_1 + actual_2
    # assert @stat.collect_seasons("18")["20152016"].include?(2015020086)
  # end

  # def test_total_games_played_per_season
  #
  #   assert_equal 60, @stat.total_games_played_per_season_by_team["20122013"][3]
  # end

  # def test_how_many_games_each_team_won_per_season
  #
  # end

end
