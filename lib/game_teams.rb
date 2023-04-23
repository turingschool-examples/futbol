class GameTeams
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :tackles

  def initialize(row)
    @game_id = row[:game_id]
    @team_id = row[:team_id]
    @hoa = row[:hoa]
    @result = row[:result]
    @head_coach = row[:head_coach]
    @goals = row[:goals].to_i
    @tackles = row[:tackles].to_i
  end
end