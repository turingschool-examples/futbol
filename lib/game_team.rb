class GameTeam
  attr_reader :team_id,
              :HoA,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :pwr_play_ops,
              :pwr_play_goals,
              :face_off_win_percent,
              :giveaways,
              :takeaways

  def initialize(game_id)
    @team_id = game_id[:team_id]
    @HoA = game_id[:HoA]
    @result = game_id[:result]
    @settled_in = game_id[:settled_in]
    @head_coach = game_id[:head_coach]
    @goals = game_id[:goals]
    @shots = game_id[:shots]
    @tackles = game_id[:tackles]
    @pim = game_id[:pim]
    @pwr_play_goals = game_id[:power_play_goals]
    @pwr_play_ops = game_id[:power_play_opportunites]
    @face_off_win_percent = game_id[:face_off_win_percentage]
    @giveaways = game_id[:giveaways]
    @takeaways = game_id[:takeaways]
  end
end