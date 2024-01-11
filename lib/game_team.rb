class GameTeam
   attr_reader :game_id,
               :team_id, 
               :hoa, 
               :result, 
               :head_coach, 
               :goals, 
               :shots, 
               :tackles
               
   def initialize(game_team_details)
      @game_id = game_team_details[:game_id]
      @team_id = game_team_details[:team_id].to_i
      @hoa = game_team_details[:hoa]
      @result = game_team_details[:result]
      @head_coach = game_team_details[:head_coach]
      @goals = game_team_details[:goals].to_i
      @shots = game_team_details[:shots].to_i
      @tackles = game_team_details[:tackles].to_i
   end
end