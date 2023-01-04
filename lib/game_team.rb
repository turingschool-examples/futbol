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
                :giveaways,
                :takeaways

  def initialize(info)
    @game_id = info[:game_id]
    @team_id = info[:team_id]
    @hoa = info[:hoa]
    @result = info[:result]
    @settled_in = info[:settled_in]
    @head_coach = info[:head_coach]
    @goals = info[:goals].to_i
    @shots = info[:shots].to_i
    @tackles = info[:tackles].to_i
    @pim = info[:pim].to_i
    @power_play_opportunities = info[:powerplayopportunities].to_i
    @power_play_goals = info[:powerplaygoals].to_i
    @faceoff_win_percentage = info[:faceoffwinpercentage].to_f
    @giveaways = info[:giveaways].to_i
    @takeaways = info[:takeaways].to_i
  end
end
