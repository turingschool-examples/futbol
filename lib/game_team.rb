class GameTeam
  attr_reader :team_id, :game_id, :hoa, :result, :settled_in, :head_coach, :goals, :shots, :tackles, :pim, :powerPlayOpportunities, :powerPlayGoals, :faceOffWinPercentage, :giveaways, :takeaways

  def initialize(row)
    @team_id = row[:team_id]
    @game_id = row[:game_id]
    @hoa = row[:hoa]
    @result = row[:result]
    @settled_in = row[:settled_in]
    @head_coach = row[:head_coach]
    @goals = row[:goals]
    @shots = row[:shots]
    @tackles = row[:tackles]
    @pim = row[:pim]
    @powerPlayOpportunities = row[:powerPlayOpportunities]
    @powerPlayGoals = row[:powerPlayGoals]
    @faceOffWinPercentage = row[:faceOffWinPercentage]
    @giveaways = row[:giveaways]
    @takeaways = row[:takeaways]
  end
end
