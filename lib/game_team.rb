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
    @goals = info[6]
    @shots = info[7]
    @tackles = info[8]
    @pim = info[9]
    @power_play_opportunities = info[10]
    @power_play_goals = info[11]
    @face_off_win_percentage = info[12]
    @giveaways = info[13]
    @takeaways = info[14]
  end
end
