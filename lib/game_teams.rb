require "csv"

class GameTeam
    attr_reader

    def initialize(game_team_data)
        @team_id = game_team_file[:team_id]
        @home_or_away = game_team_file[:hoa]
        @result = game_team_file[:result]
        @head_coach = game_team_file[:head_coach]
        @goals = game_team_file[:goals].to_i
        @shots = game_team_file[:shots].to_i
        @tackles = game_team_file[:tackles].to_i
    end




end