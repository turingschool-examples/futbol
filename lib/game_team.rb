class GameTeam
    attr_reader :game_id,
                :team_id, 
                :home_or_away_game, 
                :result, 
                :settled_in, 
                :head_coach, 
                :goals, 
                :shots, 
                :tackles, 
                :pentalty_infraction_min, 
                :power_play_opportunities, 
                :power_play_goals, 
                :face_off_win_percentage, 
                :give_aways, 
                :take_aways

    def initialize(game_id, team_id, home_or_away_game, result, settled_in, head_coach, goals, shots, tackles, pentalty_infraction_min, power_play_opportunities, power_play_goals, face_off_win_percentage, give_aways, take_aways)
        @game_id = game_id
        @team_id = team_id
        @home_or_away_game = home_or_away_game
        @result = result
        @settled_in = settled_in
        @head_coach = head_coach
        @goals = goals.to_i
        @shots = shots.to_i
        @tackles = tackles.to_i
        @pentalty_infraction_min = pentalty_infraction_min.to_i
        @power_play_opportunities = power_play_opportunities.to_i
        @power_play_goals = power_play_goals.to_i
        @face_off_win_percentage = face_off_win_percentage.to_f
        @give_aways = give_aways.to_i
        @take_aways = take_aways.to_i
    end
end