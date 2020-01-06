class GameTeams
  attr_reader :team_id,
              :game_id,
              :hoa,
              :head_coach,
              :shots,
              :tackles

  def initialize(row)
    @game_id = row[:game_id]
    @hoa = row[:hoa]
    @team_id = row[:team_id]
    @head_coach = row[:head_coach]
    @shots = row[:shots]
    @tackles = row[:tackles]
  end
end
