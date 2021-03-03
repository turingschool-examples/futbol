require './test/test_helper'
require './lib/game_team'

class GameTeamTest < MiniTest::Test

  def test_it_exists_with_attributes
    fake_data = {game_id: "2012030221", team_id: "3", hoa: "away",
                result: "LOSS", settled_in: "OT",
                head_coach: "John Tortorella", goals: 2, shots: 8, tackles: 44,
                pim: 8, powerplayopportunities: 3, powerplaygoals: 0,
                faceoffwinpercentage: 44.8, giveaways: 17, takeaways: 7}

    game_team = GameTeam.new(fake_data)

    assert_instance_of GameTeam, game_team
    assert_equal "2012030221", game_team.game_id
    assert_equal "3", game_team.team_id
    assert_equal "LOSS", game_team.result
    assert_equal "John Tortorella", game_team.head_coach
    assert_equal 2, game_team.goals
    assert_equal 8, game_team.shots
    assert_equal 44, game_team.tackles
  end

  def test_is_game_pair?
    fake_data1 = {game_id: "2012030221", team_id: "3", hoa: "away",
                result: "LOSS", settled_in: "OT",
                head_coach: "John Tortorella", goals: 2, shots: 8, tackles: 44,
                pim: 8, powerplayopportunities: 3, powerplaygoals: 0,
                faceoffwinpercentage: 44.8, giveaways: 17, takeaways: 7}

    fake_data2 = {game_id: "2012030221", team_id: "6", hoa: "home",
                result: "WIN", settled_in: "OT",
                head_coach: "Claude Julien", goals: 3, shots: 12, tackles: 51,
                pim: 6, powerplayopportunities: 4, powerplaygoals: 1,
                faceoffwinpercentage: 55.2, giveaways: 4, takeaways: 5}

    fake_data3 = {game_id: "2012030222", team_id: "3", hoa: "away",
                result: "LOSS", settled_in: "REG",
                head_coach: "John Tortorella", goals: 2, shots: 9, tackles: 33,
                pim: 11, powerplayopportunities: 5, powerplaygoals: 0,
                faceoffwinpercentage: 51.7, giveaways: 1, takeaways: 4}

    game_team1 = GameTeam.new(fake_data1)
    game_team2 = GameTeam.new(fake_data2)
    game_team3 = GameTeam.new(fake_data3)

    assert_equal true, game_team1.is_game_pair?(game_team2)
    assert_equal false, game_team1.is_game_pair?(game_team3)
  end
end 
