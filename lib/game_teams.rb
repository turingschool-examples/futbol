require "csv"

class GameTeam
    attr_reader :team_id,
                :home_or_away,
                :result,
                :head_coach,
                :goals,
                :shots,
                :tackles

    def initialize(game_team_data)
        @team_id = game_team_data[:team_id].to_i
        @home_or_away = game_team_data[:hoa]
        @result = game_team_data[:result]
        @head_coach = game_team_data[:head_coach]
        @goals = game_team_data[:goals].to_i
        @shots = game_team_data[:shots].to_i
        @tackles = game_team_data[:tackles].to_i
    end




end