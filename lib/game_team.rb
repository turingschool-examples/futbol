class GameTeam
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :face_off_win_percentage,

  def initialize(game_teams_data)
        @game_id = game_teams_data[:game_id]
        @team_id = game_teams_data[:team_id]
        @hoa = game_teams_data[:hoa]
        @result = game_teams_data[:result]
        @head_coach = game_teams_data[:head_coach]
        @goals = game_teams_data[:goals].to_i
        @shots = game_teams_data[:shots].to_i
        @tackles = game_teams_data[:tackles].to_i
  end

end