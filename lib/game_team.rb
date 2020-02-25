class GameTeam

  attr_reader :game_id,
              :team_id,
              :home_away,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :power_play_opps,
              :power_play_goals,
              :face_off_win_pct,
              :giveaways,
              :takeaways

  def initialize(details)
    @game_id = details[:game_id]
    @team_id = details[:team_id].to_i
    @home_away = details[:home_away]
    @result = details[:result]
    @settled_in = details[:settled_in]
    @head_coach = details[:head_coach]
    @goals = details[:goals].to_i
    @shots = details[:shots].to_i
    @tackles = details[:tackles].to_i
    @pim = details[:pim].to_i
    @power_play_opps = details[:power_play_opps].to_i
    @power_play_goals = details[:power_play_goals].to_i
    @face_off_win_pct = details[:face_off_win_pct].to_f
    @giveaways = details[:giveaways].to_i
    @takeaways = details[:takeaways].to_i
  end
end
