require './test/test_helper'
require './lib/games'
require './lib/team'
require './lib/games_teams'
require 'pry'

class GamesTest < Minitest::Test

  def setup
    Games.from_csv('./data/games_dummy.csv')
    @game = Games.all[0]

    Team.from_csv('./data/teams.csv')
    @team = Team.all[0]


  end

  def test_it_exists
    assert_instance_of Games, @game
  end
end
