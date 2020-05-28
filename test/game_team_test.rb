require 'csv'
require_relative '../test/test_helper'
require_relative '../lib/game_team'
require 'pry';

class GameTeamTest < Minitest::Test

  def setup

    expected = ({
      game_id: 2012020511,
      team_id: 15,
      hoa: "away",
      result: "TIE",
      settled_in: "SO",
      head_coach: "Adam Oates",
      goals: 3,
      shots: 9,
      tackles: 19,
      pim: 6,
      powerplayopportunities: 4,
      powerplaygoals: 1,
      faceoffwinpercentage: 52.5,
      giveaways: 3,
      takeaways: 2
    })
    @game_team = GameTeam.new(expected)
    @game_team_data = CSV.read('../test/fixtures/game_teams_fixture.csv', headers: true, header_converters: :symbol)
    @game_team_2 = GameTeam.new(@game_team_data[1])
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team
  end

  def test_it_has_readable_attributes
    assert_equal 2012020511, @game_team.game_id
    assert_equal 15, @game_team.team_id
    assert_equal "away", @game_team.hoa
    assert_equal "TIE", @game_team.result
    assert_equal "SO", @game_team.settled_in
    assert_equal "Adam Oates", @game_team.head_coach
    assert_equal 3, @game_team.goals
    assert_equal 9, @game_team.shots
    assert_equal 19, @game_team.tackles
    assert_equal 6, @game_team.pim
    assert_equal 4, @game_team.powerplayopportunities
    assert_equal 1, @game_team.powerplaygoals
    assert_equal 52.5, @game_team.faceoffwinpercentage
    assert_equal 3, @game_team.giveaways
    assert_equal 2, @game_team.takeaways
  end

  def test_it_can_read_from_csv
    assert_instance_of GameTeam, @game_team_2

    assert_equal 2012020511, @game_team_2.game_id
    assert_equal 7, @game_team_2.team_id
    assert_equal "home", @game_team_2.hoa
    assert_equal "TIE", @game_team_2.result
    assert_equal "SO", @game_team_2.settled_in
    assert_equal "Ron Rolston", @game_team_2.head_coach
    assert_equal 3, @game_team_2.goals
    assert_equal 5, @game_team_2.shots
    assert_equal 33, @game_team_2.tackles
    assert_equal 10, @game_team_2.pim
    assert_equal 2, @game_team_2.powerplayopportunities
    assert_equal 1, @game_team_2.powerplaygoals
    assert_equal 47.5, @game_team_2.faceoffwinpercentage
    assert_equal 4, @game_team_2.giveaways
    assert_equal 13, @game_team_2.takeaways
  end

end
