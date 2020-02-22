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

  def test_it_returns_count_of_teams
    assert_equal 32, @league_stat.count_of_teams
  end

end
