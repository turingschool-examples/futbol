module Calculable

  def average_of(total, out_of)
    total / out_of.to_f
  end

  def game_team_ids(value)
    @game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = value
      acc
    end
  end
end
