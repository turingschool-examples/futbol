class GameTeam 
  @@gameteam = []

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

  def initialize(attributes)
    @game_id                    = attributes[:game_id]
    @team_id                    = attributes[:team_id]
    @hoa                        = attributes[:hoa]
    @result                     = attributes[:result]
    @settled_in                 = attributes[:settled_in]
    @head_coach                 = attributes[:head_coach]
    @goals                      = attributes[:goals]
    @shots                      = attributes[:shots]
    @tackles                    = attributes[:tackles]
    @pim                        = attributes[:pim]
    @power_play_opportunities   = attributes[:powerplayopportunities]
    @power_play_goals           = attributes[:powerplaygoals]
    @face_off_win_percentage    = attributes[:faceoffwinpercentage]
    @giveaways                  = attributes[:giveaways]
    @takeaways                  = attributes[:takeaways]
    @@gameteam << self
  end

  def self.gameteam
    @@gameteam
  end
end