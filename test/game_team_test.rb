require "./test/test_helper"
require './lib/stat_tracker'
require './lib/game_teams_manager'
require './lib/game_team'
require 'pry';
require 'mocha/minitest'

class GameTeamTest < Minitest::Test
  def setup
    data = {
            'game_id'                 => '2012030221',
            'team_id'                 => '3',
            'HoA'                     => 'away',
            'result'                  => 'LOSS',
            'settled_in'              => 'OT',
            'head_coach'              => 'John Tortorella',
            'goals'                   => '2',
            'shots'                   => '8',
            'tackles'                 => '44',
            'pim'                     => '8',
            'powerPlayOpportunities'  => '3',
            'powerPlayGoals'          => '0',
            'faceOffWinPercentage'    => '44.8',
            'giveaways'               => '17',
            'takeaways'               => '7'
            }
    game_path = './data/dummy_game.csv'
    team_path = './data/dummy_teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)
    manager = GameTeamsManager.new(game_teams_path, stat_tracker)
    @game_team = GameTeam.new(data, manager)
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team
  end

  def test_it_can_find_season_id
    assert_equal '20122013', @game_team.season_id
  end
end
