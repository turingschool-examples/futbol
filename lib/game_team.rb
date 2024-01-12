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
        @goals = goals 
        @shots = shots
        @tackles = tackles
        @pentalty_infraction_min = pentalty_infraction_min
        @power_play_opportunities = power_play_opportunities
        @power_play_goals = power_play_goals
        @face_off_win_percentage = face_off_win_percentage
        @give_aways = give_aways
        @take_aways = take_aways
    end
end