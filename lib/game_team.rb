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

  def initialize(params)
    @game_id                = params["game_id"]
    @team_id                = params["team_id"]
    @hoa                    = params["hoa"]
    @result                 = params["result"]
    @settled_in             = params["settled_in"]
    @head_coach             = params["head_coach"]
    @goals                  = params["goals"]
    @shots                  = params["shots"]
    @tackles                = params["tackles"]
    @pim                    = params["pim"]
    @powerplayopportunities = params["powerplayopportunities"]
    @powerplaygoals         = params["powerplaygoals"]
    @faceoffwinpercentage   = params["faceoffwinpercentage"]
    @giveaways              = params["giveaways"]
    @takeaways              = params["takeaways"]
  end
end
