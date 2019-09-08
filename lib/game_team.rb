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
              :pp_opportunities,
              :pp_goals,
              :face_off_win_percentage,
              :giveaways,
              :takeaways

  def initialize(game_team_info)
    @game_id = game_team_info[0]
    @team_id = game_team_info[1]
    @hoa = game_team_info[2]
    @result = game_team_info[3]
    @settled_in = game_team_info[4]
    @head_coach = game_team_info[5]
    @goals = game_team_info[6].to_i
    @shots = game_team_info[7].to_i
    @tackles = game_team_info[8].to_i
    @pim = game_team_info[9].to_i
    @pp_opportunities = game_team_info[10].to_i
    @pp_goals = game_team_info[11].to_i
    @face_off_win_percentage = game_team_info[12].to_f
    @giveaways = game_team_info[13].to_i
    @takeaways = game_team_info[14].to_i
  end

end
