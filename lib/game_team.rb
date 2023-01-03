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
                :faceoff_win_percentage,
                :give_aways,
                :take_aways

  def initialize(info)
    @game_id = info[:game_id]
    @team_id = info[:team_id]
    @hoa = info[:hoa]
    @result = info[:result]
    @settled_in = info[:settled_in]
    @head_coach = info[:head_coach]
    @goals = info[:goals]
    @shots = info[:shots]
    @tackles = info[:tackles]
    @pim = info[:pim]
    @power_play_opportunities = info[:power_play_opportunities]
    @power_play_goals = info[:power_play_goals]
    @faceoff_win_percentage = info[:faceoff_win_percentage]
    @give_aways = info[:give_aways]
    @take_aways = info[:take_aways]
  end
end
