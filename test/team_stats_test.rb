require_relative 'test_helper'
# require './fixtures/teams_truncated'
# require './data/teams_sample.csv'
require './lib/team.rb'

class TeamStatsTest < MiniTest::Test
  def setup
    require 'pry'; binding.pry
    @team = Team.new
    @team_collection = Team.all
  end

  def test_it_can_get_team_info
    expected = {
      team_id: 7,
      franchise_id: 19,
      teamName: 'Utah Royals FC',
      abbreviation: 'URF',
      Stadium: 'Rio Tinto Stadium',
      link: '/api/v1/teams/7'
    }

    new_team = mock('team')
    new_team.stubs(:team_info).returns(expected)

    assert_equal expected, new_team.team_info
  end

  def test_it_can_get_best_season
  end

  def test_it_can_get_worst_season
  end

  def test_it_can_get_average_win_percentage
  end

  def test_it_can_get_most_goals_scored
  end

  def test_it_can_get_fewest_goals_scored
    assert_equal 0, Team.all.fewest_goals_scored('7')
  end

  def test_it_can_get_favorite_opponent
  end

  def test_it_can_get_rival
  end

  def test_it_can_get_biggest_team_blowout
  end

  def test_it_can_get_worst_loss
  end

  def test_it_can_get_head_to_head
  end

  def test_it_can_get_seasonal_summary
  end
end
