require_relative 'stat_tracker'
class GameTeams

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

  def initialize(row)
    @game_id =        row[:game_id]
    @team_id =        row[:team_id]
    @hoa =            row[:HoA]
    @result =         row[:result]
    @settled_in =     row[:settled_in]
    @head_coach =     row[:head_coach]
    @goals =          row[:goals]
    @tackles =        row[:tackles]
    @pim =            row[:pim]
    @powerplayopp =   row[:powerPlayOpportunities]
    @powerplaygoals = row[:powerPlayGoals]
    @faceoffwinperc = row[:faceOffWinPercentage]
    @giveaways =      row[:giveaways]
    @takeaways =      row[:takeaways]
  end
end