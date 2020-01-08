require 'minitest/autorun'
require 'minitest/pride'
require_relative 'test_helper'
require './lib/team'
require './lib/game_team'
require './lib/tackle'
require './lib/game'

class TackleTest < Minitest::Test

  def setup
    Tackle.new
    @team_path = './test/dummy/teams_trunc.csv'
    @game_teams = Team.from_csv(@team_path)
    @game_team_path = './test/dummy/game_teams_trunc.csv'
    @game_teams = GameTeam.from_csv(@game_team_path)
    @game_path = './test/dummy/games_trunc.csv'
    @games = Game.from_csv(@game_path)
  end

  def test_most_tackles
    assert_equal "Dallas", Tackle.most_tackles("201203022015")
  end


end
