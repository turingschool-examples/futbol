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
              :takeaways,
              :list

  def initialize(row, list)
    @game_id                    = row[:game_id].to_i
    @team_id                    = row[:team_id].to_i
    @hoa                        = row[:hoa].to_s
    @result                     = row[:result].to_s
    @settled_in                 = row[:settled_in].to_s
    @head_coach                 = row[:head_coach].to_s
    @goals                      = row[:goals].to_i
    @shots                      = row[:shots].to_i
    @tackles                    = row[:tackles].to_i
    @pim                        = row[:pim].to_i
    @powerplayopportunities     = row[:powerplayopportunities].to_i
    @powerplaygoals             = row[:powerplaygoals].to_i
    @faceoffwinpercentage       = row[:faceoffwinpercentage].to_f
    @giveaways                  = row[:giveaways].to_i
    @takeaways                  = row[:takeaways].to_i

    @list = list
  end

end