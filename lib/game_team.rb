class GameTeam
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              # :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles
              # :pim,
              # :powerplayopportunities,
              # :powerplaygoals,
              # :faceoffwinpercentage,
              # :giveaways,
              # :takeaways

  def initialize(params)
    @game_id                = params["game_id"]
    @team_id                = params["team_id"]
    @hoa                    = params["HoA"]
    @result                 = params["result"]
    # @settled_in             = params["settled_in"] # Not used
    @head_coach             = params["head_coach"]
    @goals                  = params["goals"].to_i
    @shots                  = params["shots"].to_i
    @tackles                = params["tackles"].to_i
    # @pim                    = params["pim"] # Not used
    # @powerplayopportunities = params["powerPlayOpportunities"] # Not used
    # @powerplaygoals         = params["powerPlayGoals"] # Not used
    # @faceoffwinpercentage   = params["faceOffWinPercentage"] # Not used
    # @giveaways              = params["giveaways"] # Not used
    # @takeaways              = params["takeaways"] # Not used
  end
end
