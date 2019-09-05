class GameTeam
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :power_play_opportunities,
              :power_play_goals,
              :face_off_win_percentage,
              :giveaways,
              :takeaways

  def initialize(info)
    @game_id = info[0]
    @team_id = info[1]
    @hoa = info[2]
    @result = info[3]
    @settled_in = info[4]
    @head_coach = info[5]
    @goals = info[6].to_i
    @shots = info[7].to_i
    @tackles = info[8].to_i
    @pim = info[9].to_i
    @power_play_opportunities = info[10].to_i
    @power_play_goals = info[11].to_i
    @face_off_win_percentage = info[12].to_f
    @giveaways = info[13].to_i
    @takeaways = info[14].to_i
  end
end
