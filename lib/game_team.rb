

class GameTeam
    attr_reader :season_id,
                :team_id,
                :home_or_away,
                :result,
                :head_coach,
                :goals,
                :shots,
                :tackles

    def initialize(game_id, team_id, home_or_away, result, head_coach, goals, shots, tackles)
        @season_id = get_season_id(game_id)
        @team_id = team_id
        @home_or_away = home_or_away
        @result = result
        @head_coach = head_coach
        @goals = goals
        @shots = shots
        @tackles = tackles
    end

    def get_season_id(game_id)
        first_four = game_id[0,4].to_i
        second_four = first_four + 1
        game_id[0,4] + second_four.to_s
    end

end