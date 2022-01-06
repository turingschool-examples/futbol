class GameTeam
  attr_reader :team_id, :game_id, :hoa, :result, :settled_in, :head_coach, :goals, :shots, :tackles, :pim, :powerPlayOpportunities, :powerPlayGoals, :faceOffWinPercentage, :giveaways, :takeaways

  def initialize(team_id, game_id, hoa, result, settled_in, head_coach, goals, shots, tackles, pim, powerPlayOpportunities, powerPlayGoals, faceOffWinPercentage, giveaways, takeaways)
    @team_id = team_id
    @game_id = game_id
    @hoa = hoa
    @result = result
    @settled_in = settled_in
    @head_coach = head_coach
    @goals = goals
    @shots = shots
    @tackles = tackles
    @pim = pim
    @powerPlayOpportunities = powerPlayOpportunities
    @powerPlayGoals = powerPlayGoals
    @faceOffWinPercentage = faceOffWinPercentage
    @giveaways = giveaways
    @takeaways = takeaways
  end
end
