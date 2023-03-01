class GameTeam

  attr_reader :game_id, 
              :team_id,
              :hoa, 
              :result,
              :head_coach,
              :goals,
              :shots, 
              :tackles

    def initialize(game_team_data)
      @game_id = game_team_data[:game_id]
      @team_id = game_team_data[:team_id]
      @hoa = game_team_data[:hoa]
      @result = game_team_data[:result]
      @head_coach = game_team_data[:head_coach]
      @goals = game_team_data[:goals]
      @shots = game_team_data[:shots]
      @tackles = game_team_data[:tackles]
    end
end