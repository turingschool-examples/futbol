require 'csv'
require './test/test_helper'
require './lib/team'
require 'mocha/minitest'
require './lib/game_team'

class TeamsTest < Minitest::Test

  def setup
    csv = CSV.read('./test/data/game_teams_sample.csv', headers: true, header_converters: :symbol)
    all_games = csv.map do |row|
      GameTeam.new(row)
    end

    csv = CSV.read('./test/data/teams_sample.csv', headers: true, header_converters: :symbol)
    @teams = csv.map do |row|
      all_team_games = all_games.find_all do |game|
        row[:team_id] == game.team_id
      end
      Team.new(row, all_team_games)
    end
  end

  def test_it_exists
    @teams.each do |team|
      assert_instance_of Team, team
    end
  end

  def test_it_has_attributes
    team = @teams.first
    assert_equal "3", team.team_id
    assert_equal 10, team.franchise_id
    assert_equal "Houston Dynamo", team.team_name
    assert_equal "HOU", team.abbreviation
  end

  def test_it_has_a_win_percentage
    team = @teams.find {|team| team.team_id == "8"}
    # 1 win 3 losses 1 tie
    win_percentage = (1 / 5.0).round(2)
    assert_equal win_percentage, team.win_percentage
  end
end
