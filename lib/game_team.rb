class GameTeam
   def initialize(game_team_details)
      @game_id = game_team_details[:game_id]
      @team_id = game_team_details[:team_id]
      @home_or_away = game_team_details[:HoA]
      @result = game_team_details[:result]
      @coach = game_team_details[:head_coach]
      @goals = game_team_details[:goals]
      @shots = game_team_details[:shots]
      @tackles = game_team_details[:tackles]
   end
end