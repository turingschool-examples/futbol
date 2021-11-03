class TGStat
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
              :ppo,
              :ppg,
              :fowp,
              :giveaways,
              :takeaways

  def initialize(stat)
    @game_id = stat[:game_id]
    @team_id = stat[:team_id]
    @hoa = stat[:hoa]
    @result = stat[:result]
    @settled_in = stat[:settled_in]
    @head_coach = stat[:head_coach]
    @goals = stat[:goals].to_i
    @shots = stat[:shots].to_i
    @tackles = stat[:tackles].to_i
    @pim = stat[:pim].to_i
    @ppo = stat[:powerplayopportunities].to_i
    @ppg = stat[:powerplaygoals].to_i
    @fowp = stat[:faceoffwinpercentage].to_f
    @giveaways = stat[:giveaways].to_i
    @takeaways = stat[:takeaways].to_i
  end
end