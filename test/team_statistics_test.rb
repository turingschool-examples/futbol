require './test/test_helper'
require './lib/stat_tracker'

class TeamStatisticsTest < Minitest::Test
  def setup
    locations = {
      games: './fixtures/team_stats_fixture_games.csv',
      teams: './data/teams.csv',
      game_teams: './fixtures/team_stats_fixture_game_teams.csv'
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_team_info
    expected ={
           team_id: 1,
      franchise_id: 23,
         team_name: "Atlanta United",
      abbreviation: "ATL",
           stadium: "Mercedes-Benz Stadium",
              link: "/api/v1/teams/1"
    }
    actual = @stat_tracker.team_info(1)

    assert_equal expected, actual
  end

  def test_it_can_find_games_by_team_id
    games = @stat_tracker.games
    expected = [games[11], games[12], games[13], games[14], games[15], games[16], games[17], games[28], games[45]]
    # actual = @stat_tracker.games_by_team_id(26)

    assert_equal expected, @stat_tracker.games_by_team_id(26)

    different_games = [games[0], games[1], games[28], games[2], games[3], games[13], games[4], games[5]]
    expected = [games[28], games[13]]

    assert_equal expected, @stat_tracker.games_by_team_id(26, different_games)
  end

  # def test_it_can_separate_games_by_season_id
  #   # ["20122013", "20162017", "20132014"]
  # end
end
