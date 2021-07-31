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
              :power_play_opportunities,
              :power_play_goals,
              :face_off_win_percentage,
              :giveaways,
              :takeaways

  def initialize(hash)
    @game_id                  = hash[:game_id]
    @team_id                  = hash[:team_id]
    @hoa                      = hash[:hoa]
    @result                   = hash[:result]
    @settled_in               = hash[:settled_in]
    @head_coach               = hash[:head_coach]
    @goals                    = hash[:goals]
    @shots                    = hash[:shots]
    @tackles                  = hash[:tackles]
    @pim                      = hash[:pim]
    @power_play_opportunities = hash[:powerplayopportunities]
    @power_play_goals         = hash[:powerplaygoals]
    @face_off_win_percentage  = hash[:faceoffwinpercentage]
    @giveaways                = hash[:giveaways]
    @takeaways                = hash[:takeaways]
  end
end
