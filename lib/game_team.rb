class GameTeam
  attr_reader :game_id,
              :team_id,
              :home_away,
              :head_coach,
              :goals,
              :shots, 
              :tackles,
              :result
  def initialize(details)
    @game_id = details[:game_id]
    @team_id = details[:team_id]
    @home_away = details[:hoa]
    @head_coach = details[:head_coach]
    @goals= details[:goals].to_i
    @shots = details[:shots].to_i
    @tackles = details[:tackles].to_i
    @result = details[:result]
  end
end