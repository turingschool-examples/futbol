require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/game_teams'
require './lib/team'
require './lib/game'
require './lib/team_repository'


class TeamRepositoryTest < Minitest::Test
  # require "./lib/team_repository"
#
# team_repository =TeamRepository.new('./data/teams.csv')
#move all Team Stats methods testing here
  def test_it_can_report_most_goals_scored
    game_repository = TeamRepository.new('./test/fixtures/game_teams_truncated.csv', './data/teams.csv')
    assert_equal 4, game_repository.most_goals_scored(6)
  end

  def test_it_can_report_fewest_goals_scored
    game_repository = TeamRepository.new('./test/fixtures/game_teams_truncated.csv', './data/teams.csv')
    assert_equal 1, game_repository.fewest_goals_scored(6)
  end
end
