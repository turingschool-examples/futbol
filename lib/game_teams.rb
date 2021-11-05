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

<<<<<<< HEAD
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
=======

  def initialize(row)
    @row = row[:game_id]
    @team_id = row[:team_id].to_i
    @HoA = row[:HoA]
    @result = row[:result]
    @settled_in = row[:settled_in]
    @head_coach = row[:head_coach]
    @goals = row[:goals].to_i
    @shots = row[:shots].to_i
    @tackles = row[:tackles].to_i
    @pim = row[:pim].to_i
    @powerPlayOpportunities = row[:powerPlayOpportunities].to_i
    @powerPlayGoals = row[:powerPlayGoals].to_i
    @faceOffWinPercentage = row[:faceOffWinPercentage]
    @giveaways = row[:giveaways].to_i
    @takeaways = row[:takeaways].to_i

>>>>>>> 6272cf6 (commit to save changes and switch branch)
  end
end
