class GameTeam
   attr_reader :game_id, :team_id, :hoa, :result, :head_coach, :goals, :shots, :tackles
   def initialize(game_team_details)
      @game_id = game_team_details[:game_id]
      @team_id = game_team_details[:team_id]
      @hoa = game_team_details[:hoa]
      @result = game_team_details[:result]
      @head_coach = game_team_details[:head_coach]
      @goals = game_team_details[:goals]
      @shots = game_team_details[:shots]
      @tackles = game_team_details[:tackles]
   end
end