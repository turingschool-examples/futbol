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
              :game_team_list #this is changed for clarity because it is an instance of game_team_list, not just a list in game_team

  def initialize(row, list)
    @game_id                    = row[:game_id]
    @team_id                    = row[:team_id]
    @hoa                        = row[:hoa]
    @result                     = row[:result]
    @settled_in                 = row[:settled_in]
    @head_coach                 = row[:head_coach]
    @goals                      = row[:goals].to_i
    @shots                      = row[:shots].to_i
    @tackles                    = row[:tackles].to_i
    @pim                        = row[:pim].to_i
    @powerplayopportunities     = row[:powerplayopportunities].to_i
    @powerplaygoals             = row[:powerplaygoals].to_i
    @faceoffwinpercentage       = row[:faceoffwinpercentage].to_f
    @giveaways                  = row[:giveaways].to_i
    @takeaways                  = row[:takeaways].to_i
    @game_team_list             = game_team_list

  end

end