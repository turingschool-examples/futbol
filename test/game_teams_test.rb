require_relative '../test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams'

class GameTeamsTest < Minitest::Test

  def setup
    # @game_team = GameTeams.new ({
    #   :team_id => 1,
    #   :franchiseId => 23,
    #   :teamName => "Atlanta United",
    #   :abbreviation => "ATL",
    #   # :Stadium => "Mercedes-Benz Stadium"
    #   })

      GameTeams.from_csv("./test/fixtures/game_teams.csv")
      @game_team = GameTeams.all[0]
  end

  def test_it_exists
    assert_instance_of GameTeams, @game_team
  end

end