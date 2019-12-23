require_relative '../test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams'
require './lib/team'


class GameTeamsTest < Minitest::Test

  def setup
    # @game_team = GameTeams.new ({
    #   :team_id => 1,
    #   :franchiseId => 23,
    #   :teamName => "Atlanta United",
    #   :abbreviation => "ATL",
    #   # :Stadium => "Mercedes-Benz Stadium"
    #   })

      @game_teams = GameTeams.from_csv("./test/fixtures/game_teams.csv")
      # @game_teams = GameTeams.all
      @first_game_team = GameTeams.all[0]
      Team.from_csv("./test/fixtures/teams.csv")
      @teams = Team.all
  end

  def test_it_exists
    assert_instance_of GameTeams, @first_game_team
  end

  def test_it_can_get_the_highest_winning_team
    assert_equal 'FC Dallas', GameTeams.winningest_team
  end

  def test_it_can_get_the_best_fans
    assert_equal 'FC Dallas', GameTeams.best_fans
  end

  def test_it_can_get_the_best_fans
    assert_equal ['Houston Dynamo'], GameTeams.worst_fans
  end
  
# 3 away L  L  L (0) home L (0)    
# 6 away W W L W (75) home W W W (100) 


end