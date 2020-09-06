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

  def test_it_can_separate_games_by_season_id
    season_20122013 = @stat_tracker.games.select do |game|
      game.season == "20122013"
    end
    season_20162017 = @stat_tracker.games.select do |game|
      game.season == "20162017"
    end
    season_20132014 = @stat_tracker.games.select do |game|
      game.season == "20132014"
    end
    expected = {
      "20122013" => season_20122013,
      "20162017" => season_20162017,
      "20132014" => season_20132014
    }
    actual = @stat_tracker.separate_games_by_season_id

    assert_equal expected, actual

    games = @stat_tracker.games[0..10]
    expected = {
      "20122013" => games[0..6],
      "20162017" => games[7..-1]
    }
    actual = @stat_tracker.separate_games_by_season_id(games)

    assert_equal expected, actual
  end

  def test_it_can_find_game_stats_by_team_id
    team_stats = @stat_tracker.game_teams
    expected = [team_stats[0], team_stats[2], team_stats[5], team_stats[7], team_stats[8], team_stats[11], team_stats[12]]

    assert_equal expected, @stat_tracker.game_stats_by_team_id(17)
  end

  def test_it_can_find_most_goals_scored_by_team
    assert_equal 3, @stat_tracker.most_goals_scored(17)
  end
end
