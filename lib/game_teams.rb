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

  end
end
