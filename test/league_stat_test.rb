require_relative 'test_helper'
require './lib/league_stat'
require './lib/team_collection'
require './lib/game_collection'

class LeagueStatClass < Minitest::Test

  def setup
    games_file_path = './test/fixtures/truncated_games.csv'
    teams_file_path = './data/teams.csv'
    @team_collection = TeamCollection.new(teams_file_path)
    @game_collection = GameCollection.new(games_file_path)
    @league_stat = LeagueStat.new(@team_collection.teams_list, @game_collection.games_list)
  end

  def test_it_exists
    assert_instance_of LeagueStat, @league_stat
  end

  def test_it_is_a_hash
    assert Hash, @league_stat.class
  end

  def test_it_nests_second_hash_with_default_value_0
    assert_equal 0, @league_stat.stats_by_team[:new_key][:doesnt_exist]
  end

  def test_it_creates_teams
    test_team = OpenStruct.new(team_id:100, team_name:"TestTeam")
    @league_stat.create_teams([test_team])

    assert_equal "TestTeam", @league_stat.stats_by_team[100][:team_name]
  end

  def test_it_creates_away_stats
    test_game = OpenStruct.new(
      away_team_id:101,
      home_team_id:100,
      away_goals:3,
      home_goals:2
    )
    @league_stat.game_stats_away(test_game)
    expected = {
      away_goals: 3,
      away_goals_allowed: 2,
      away_wins: 1,
    }

    assert_equal expected, @league_stat.stats_by_team[101]
  end

  def test_it_creates_home_games
    test_game = OpenStruct.new(
      away_team_id:101,
      home_team_id:100,
      away_goals:3,
      home_goals:2
    )
    @league_stat.game_stats_home(test_game)
    expected = {
      home_goals: 2,
      home_goals_allowed: 3,
      home_losses: 1,
    }

    assert_equal expected, @league_stat.stats_by_team[100]
  end

  def test_it_creates_league_stats
    test_game = OpenStruct.new(
      away_team_id:101,
      home_team_id:100,
      away_goals:3,
      home_goals:2
    )
    @league_stat.create_league_stats([test_game])
    expected_away = {
      away_goals: 3,
      away_goals_allowed: 2,
      away_wins: 1,
    }
    expected_home = {
      home_goals: 2,
      home_goals_allowed: 3,
      home_losses: 1,
    }

    assert_equal expected_away, @league_stat.stats_by_team[101]
    assert_equal expected_home, @league_stat.stats_by_team[100]
  end

  def test_it_returns_count_of_teams
    assert_equal 32, @league_stat.count_of_teams
  end

end
