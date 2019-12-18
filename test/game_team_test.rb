require_relative 'testhelper'
require_relative '../lib/game_team'

class GameTeamTest < Minitest::Test
    def test_it_exists
        game_team = GameTeam.new({})
        assert_instance_of GameTeam, game_team
    end

    def test_it_has_attributes
        game_team = GameTeam.new({
                        game_id: 2012030312,
                        team_id: 6,
                        HoA: "away",
                        result: "WIN",
                        settled_in: "REG",
                        head_coach: "Claude Julien",
                        goals: 4,
                        shots: 7,
                        tackles: 19  })

        assert_equal 2012030312, game_team.game_id
        assert_equal 6, game_team.team_id
        assert_equal "away", game_team.HoA
        assert_equal "WIN", game_team.result
        assert_equal "REG", game_team.settled_in
        assert_equal "Claude Julien", game_team.head_coach
        assert_equal 4, game_team.goals
        assert_equal 7, game_team.shots
        assert_equal 19, game_team.tackles
    end
end
