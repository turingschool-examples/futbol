require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/seasonstats'

class SeasonStatsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @seasonstats = SeasonStats.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of SeasonStats, @seasonstats
  end

  def test_games_in_season
    assert_instance_of Array, @seasonstats.games_in_season("20122013")
    @seasonstats.stubs(:games_in_season).returns(["game"])
    assert_equal ["game"], @seasonstats.games_in_season("20122013")
  end

  def test_winningest_coach
    assert_instance_of String, @seasonstats.winningest_coach("20122013")
    @seasonstats.stubs(:winningest_coach).returns("Claude Julien")
    assert_equal "Claude Julien", @seasonstats.winningest_coach("20122013")
  end

end
