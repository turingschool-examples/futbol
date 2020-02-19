require './test/test_helper'
require './lib/stat_tracker'
require './lib/game_team'

class GameTeamTest < Minitest::Test

  def setup
    StatTracker.create_items("./test/fixtures/game_teams_sample.csv", GameTeam)
    @game_team = GameTeam.all
    @new_game_team = GameTeam.new({
                                  game_id: 2012030221,
                                  team_id: 3,
                                  hoa: "away",
                                  result: "LOSS",
                                  settled_in: "OT",
                                  head_coach: "John Tortorella",
                                  goals: 2,
                                  shots: 8,
                                  tackles: 44,
                                  pim: 8,
                                  powerplayopportunities: 3,
                                  powerplaygoals: 0,
                                  faceoffwinpercentage: 44.8,
                                  giveaways: 17,
                                  takeaways: 7
                                  })
  end

  def test_it_exists
    game_team = GameTeam.new({})

    assert_instance_of GameTeam, game_team
  end

  def test_it_had_attributes
    assert_equal 2012030221, @new_game_team.game_id
    assert_equal 3, @new_game_team.team_id
    assert_equal "away", @new_game_team.hoa
    assert_equal "LOSS", @new_game_team.result
    assert_equal "OT", @new_game_team.settled_in
    assert_equal "John Tortorella", @new_game_team.head_coach
    assert_equal 2, @new_game_team.goals
    assert_equal 8, @new_game_team.shots
    assert_equal 44, @new_game_team.tackles
    assert_equal 8, @new_game_team.pim
    assert_equal 3, @new_game_team.power_play_opportunities
    assert_equal 0, @new_game_team.power_play_goals
    assert_equal 44.8, @new_game_team.face_off_win_percentage
    assert_equal 17, @new_game_team.giveaways
    assert_equal 7, @new_game_team.takeaways
  end

  def test_it_can_add_game_teams
    assert_instance_of Hash, GameTeam.all
    assert_equal 50, GameTeam.all.length
    
    assert_instance_of GameTeam, GameTeam.all[2012030221][3]
    assert_instance_of GameTeam, GameTeam.all[2012030221][6]

    assert_equal 3, GameTeam.all[2012030221][3].team_id
    assert_equal "John Tortorella", GameTeam.all[2012030221][3].head_coach
    assert_equal 6, GameTeam.all[2012030221][6].team_id
    assert_equal "Claude Julien", GameTeam.all[2012030221][6].head_coach
  end

  def test_it_can_load_all_game_teams_from_csv
    assert_equal 2012030221, GameTeam.all.keys.first
    assert_equal 2012030135, GameTeam.all.keys.last
  end

end
