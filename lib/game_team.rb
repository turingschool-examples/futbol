class GameTeam 
  @@gameteam = []

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
              :powerPlayOpportunities,
              :powerPlayGoals,
              :faceOffWinPercentage,
              :giveaways,
              :takeaways

  def initialize(attributes)
    @game_id                = attributes[:game_id]
    @team_id                = attributes[:team_id]
    @HoA                    = attributes[:hoa]
    @result                 = attributes[:result]
    @settled_in             = attributes[:settled_in]
    @head_coach             = attributes[:head_coach]
    @goals                  = attributes[:goals]
    @shots                  = attributes[:shots]
    @tackles                = attributes[:tackles]
    @pim                    = attributes[:pim]
    @powerPlayOpportunities = attributes[:powerplayopportunities]
    @powerPlayGoals         = attributes[:powerplaygoals]
    @faceOffWinPercentage   = attributes[:faceoffwinpercentage]
    @giveaways              = attributes[:giveaways]
    @takeaways              = attributes[:takeaways]
    @@gameteam << self
  end

  def self.gameteam
    @@gameteam
  end
end