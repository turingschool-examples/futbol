class GameTeam
  attr_reader :game_id,
              :team_id,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :parent

  def initialize(data, parent)
    @game_id = data[:game_id].to_i
    @team_id = data[:team_id].to_i
    @result = data[:result]
    @head_coach = data[:head_coach]
    @goals = data[:goals].to_i
    @shots = data[:shots].to_i
    @tackles = data[:tackles].to_i
    @parent = parent
  end
end
