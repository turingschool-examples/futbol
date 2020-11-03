require './test/test_helper'


class TeamCollectionTest < Minitest::Test
  def setup
    game_path       = './data/games_dummy.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }

    @stat_tracker    = StatTracker.from_csv(locations)
    @team_collection = TeamCollection.new(team_path, @stat_tracker)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of TeamCollection, @team_collection
  end

  def test_it_can_count_number_of_teams
    assert_equal 32, @team_collection.count_of_teams
  end

  def test_it_can_find_team_name
    assert_equal 'Columbus Crew SC', @team_collection.find_team_name('53')
  end

  # Team Statistics
  def test_it_can_list_team_info
    expected = {
                team_id: '20',
                franchise_id: '21',
                team_name: 'Toronto FC',
                abbreviation: 'TOR',
                link: '/api/v1/teams/20'
              }
    assert_equal expected, @team_collection.team_info('20')
  end
end
