class GameTeam
  attr_reader :game_id,
              :team_id,
              :HoA,
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

  def initialize(data, loader)
    @game_id      = data['game_id']
    @team_id = data['team_id']
    @HoA    = data['HoA']
    @result = data['result']
    @settled_in      = data['settled_in']
    @head_coach         = data['head_coach']
    @goals      = data['goals']
    @shots = data['shots']
    @tackles    = data['tackles']
    @pim = data['pim']
    @power_play_opportunities      = data['power_play_opportunities']
    @power_play_goals         = data['power_play_goals']
    @face_off_win_percentage = data['face_off_win_percentage']
    @giveaways      = data['giveaways']
    @takeaways         = data['takeaways']
  end
end
