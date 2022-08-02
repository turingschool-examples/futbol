class GameTeam
  attr_reader :game_id, :team_id, :result, :head_coach,
              :goals, :shots, :tackles
  def initialize(row)
    @game_id = row[:game_id]
    @team_id = row[:team_id]
    @result = row[:result]
    @head_coach = row[:head_coach]
    @goals = row[:goals]
    @shots = row[:shots]
    @tackles = row[:tackles]
  end
end
