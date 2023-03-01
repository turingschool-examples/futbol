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
              :give_aways,
              :take_aways

  def initialize(details)
    @game_id = details[:game_id]
    @team_id  = details[:team_id]
    @hoa = details[:hoa]
    @result = details[:result]
    @settled_in = details[:settled_in]
    @head_coach = details[:head_coach]
    @goals = details[:goals].to_i
    @shots = details[:shots].to_i
    @tackles = details[:tackles].to_i
    @pim = details[:pim].to_i
    @power_play_opportunities = details[:powerplayopportunities].to_i
    @power_play_goals = details[:powerplaygoals].to_i
    @face_off_win_percentage = details[:faceoffwinpercentage].to_f
    @give_aways = details[:giveaways].to_i
    @take_aways = details[:takeaways].to_i
  end
end