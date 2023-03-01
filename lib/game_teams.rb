class GameTeams
  attr_reader :coach,
              :goals,
              :shots,
              :tackles,
              :team_id,
              :game_id,
              :season_id,
              :result,
              :home_away

  def initialize(details)
    @coach = details[:head_coach]
    @goals = details[:goals]
    @shots = details[:shots]
    @tackles = details[:tackles]
    @team_id = details[:team_id]
    @game_id = details[:game_id]
    @season_id = @game_id[0..3]
    @result = details[:result]
    @home_away = details[:hoa]
  end
end