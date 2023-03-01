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
              :powerplayopportunities,
              :powerplaygoals,
              :faceoffwinpercentage,
              :giveaways,
              :takeaways

  def initialize(details)
    @game_id = details[:game_id]
    @team_id  = details[:team_id]
    @hoa = details[:hoa]
    @result = details[:result]
    @settled_in = details[:settled_in]
    @head_coach = details[:head_coach]
    @goals = details[:goals]
    @shots = details[:shots]
    @tackles = details[:tackles]
    @pim = details[:pim]
    @powerplayopportunities = details[:powerplayopportunities]
    @powerplaygoals = details[:powerplaygoals]
    @faceoffwinpercentage = details[:faceoffwinpercentage]
    @giveaways = details[:giveaways]
    @takeaways = details[:takeaways]
  end
end