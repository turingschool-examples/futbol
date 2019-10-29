require 'minitest'
require 'minitest/autorun'
require './test/test_helper'
require './lib/stat_tracker'
require_relative '../lib/season_module'

class SeasonTest < Minitest::Test
  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'
    locations = { games: game_path, teams: team_path, game_teams: game_teams_path }
    @stat_tracker = StatTracker.from_csv(locations)
  end
end
