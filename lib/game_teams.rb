require 'CSV'

class GameTeams
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

  def initialize(info_hash)
    @game_id                = info_hash[:game_id].to_i
    @team_id                = info_hash[:team_id].to_i
    @hoa                    = info_hash[:HoA]
    @result                 = info_hash[:result]
    @settled_in             = info_hash[:settled_in]
    @head_coach             = info_hash[:head_coach]
    @goals                  = info_hash[:goals].to_i
    @shots                  = info_hash[:shots].to_i
    @tackles                = info_hash[:tackles].to_i
    @pim                    = info_hash[:pim].to_i
    @powerplayopportunities = info_hash[:powerPlayOpportunities].to_i
    @powerplaygoals         = info_hash[:powerPlayGoals].to_i
    @faceoffwinpercentage   = info_hash[:faceOffWinPercentage].to_f
    @giveaways              = info_hash[:giveaways].to_i
    @takeaways              = info_hash[:takeaways].to_i
  end
end
