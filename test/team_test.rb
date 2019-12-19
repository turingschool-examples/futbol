require_relative 'test_helper'
require_relative '../lib/team'
require_relative '../lib/stat_tracker'

class TeamTest < MiniTest::Test
  def setup
    locations = game_path = './test/fixtures/truncated_games.csv'
		team_path = './data/teams.csv'
		game_teams_path = './test/fixtures/truncated_game_teams.csv'
		locations = {
		  games: game_path,
		  teams: team_path,
		  game_teams: game_teams_path
		}

    @stat_tracker = StatTracker.new(locations)
    @team = Team.new({team_id: 3,
                      franchiseid: 10,
                      teamname: "Houston Dynamo",
                      abbreviation: "HOU",
                      stadium: "BBVA Stadium",
                      link: "/api/v1/teams/3"})
  end

  def test_team_is_made_with_accessible_states
    assert_instance_of Team, @team
    assert_equal 3, @team.team_id
    assert_equal 10, @team.franchise_id
    assert_equal "Houston Dynamo", @team.team_name
    assert_equal "HOU", @team.abbreviation
    assert_equal "BBVA Stadium", @team.stadium
    assert_equal "/api/v1/teams/3", @team.link
  end

  # def test_team_has_total_stats
  #   skip
  # end
  #
  def test_has_hash_of_info
    expected = {team_id: 3,
                franchise_id: 10,
                team_name: "Houston Dynamo",
                abbreviation: "HOU",
                link: "/api/v1/teams/3"}

    assert_equal expected, @team.team_info
  end

  def test_can_pull_its_best_season_object
    @team.stats_by_season
  end

  def test_that_teams_have_average_away_scores
    assert_equal 2.6, @team.average_goals_away
  end

  def test_that_home_teams_have_average_home_scores
    assert_equal 1.11, @team.average_goals_home

  end
end
