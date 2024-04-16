

class GameTeam
    attr_reader :team_id,
                :home_or_away,
                :result,
                :head_coach,
                :goals,
                :shots,
                :tackles

    def initialize(team_id, home_or_away, result, head_coach, goals, shots, tackles)
        @team_id = team_id
        @home_or_away = home_or_away
        @result = result
        @head_coach = head_coach
        @goals = goals
        @shots = shots
        @tackles = tackles
    end
end