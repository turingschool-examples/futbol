class GameTeam
  attr_reader :game_id, :team_id, :tackles, :goals,
              :shots, :result, :head_coach

   def initialize(raw_data)
    @game_id = raw_data[:game_id]
    @team_id = raw_data[:team_id].strip
    @result = raw_data[:result]
    @head_coach = raw_data[:head_coach]
    @goals = raw_data[:goals].to_i
    @shots = raw_data[:shots].to_i
    @tackles = raw_data[:tackles].to_i
   end
end
