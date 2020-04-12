require './test/test_helper'
require './lib/game_team.rb'

class GameTeamTest < Minitest::Test

  def setup
    @base_game_team = GameTeam.new({
        game_id: "2012030221",
        team_id: "3",
        hoa: "away",
        result: "LOSS",
        settled_in: "OT",
        head_coach: "John Tortorella",
        goals: '2',
        shots: '8',
        tackles: '44',
        pim: '8',
        powerplayopportunities: '3',
        powerplaygoals: '0',
        faceoffwinpercentage: '44.8',
        giveaways: '17',
        takeaways: '7'
        })

    GameTeam.from_csv("./test/fixtures/games_teams_fixture.csv")
    @last_game_team = GameTeam.all[-1]
  end

  def test_it_exists
    assert_instance_of GameTeam, @base_game_team
  end

  def test_it_has_readable_attributes
    assert_equal 2012030221, @base_game_team.game_id
    assert_equal "3", @base_game_team.team_id
    assert_equal "away", @base_game_team.hoa
    assert_equal "LOSS", @base_game_team.result
    assert_equal "OT", @base_game_team.settled_in
    assert_equal "John Tortorella", @base_game_team.head_coach
    assert_equal 2, @base_game_team.goals
    assert_equal 8, @base_game_team.shots
    assert_equal 44, @base_game_team.tackles
    assert_equal 8, @base_game_team.pim
    assert_equal 3, @base_game_team.powerplayopportunities
    assert_equal 0, @base_game_team.powerplaygoals
    assert_equal 44.8, @base_game_team.faceoffwinpercentage
    assert_equal 17, @base_game_team.giveaways
    assert_equal 7, @base_game_team.takeaways
  end

  def test_it_reads_game_teams_from_csv
    assert_equal 2012020122, @last_game_team.game_id
    assert_equal "2", @last_game_team.team_id
    assert_equal "home", @last_game_team.hoa
    assert_equal "LOSS", @last_game_team.result
    assert_equal "REG", @last_game_team.settled_in
    assert_equal "Jack Capuano", @last_game_team.head_coach
    assert_equal 0, @last_game_team.goals
    assert_equal 5, @last_game_team.shots
    assert_equal 24, @last_game_team.tackles
    assert_equal 15, @last_game_team.pim
    assert_equal 7, @last_game_team.powerplayopportunities
    assert_equal 0, @last_game_team.powerplaygoals
    assert_equal 53.4, @last_game_team.faceoffwinpercentage
    assert_equal 12, @last_game_team.giveaways
    assert_equal 6, @last_game_team.takeaways
  end

end
