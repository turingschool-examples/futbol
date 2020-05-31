class GameTeams
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles

   def initialize(game_teams_param)
     @game_id = game_teams_param[:game_id]
     @team_id = game_teams_param[:team_id]
     @hoa = game_teams_param[:hoa]
     @result = game_teams_param[:result]
     @head_coach = game_teams_param[:head_coach]
     @goals = game_teams_param[:goals].to_i
     @shots = game_teams_param[:shots].to_i
     @tackles = game_teams_param[:tackles].to_i
   end

end
