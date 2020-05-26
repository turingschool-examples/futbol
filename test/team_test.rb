require 'csv'
require_relative 'test_helper'
require './lib/team'
require 'pry'

class TeamTest < MiniTest::Test

  def setup
        @team = Team.new({team_id: "8",
                          franchiseId: "1",
                          teamName: "New York Red Bulls",
                          abbreviation: "NY",
                          Stadium: "Red Bull Arena",
                          link: "/api/v1/teams/8"
                })
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_it_has_attributes
    assert_equal "New York Red Bulls", @team.team_name
    assert_equal "Red Bull Arena", @team.stadium
    assert_equal "/api/v1/teams/8", @team.link
  end
end
