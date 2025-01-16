class GameTeam 
  attr_reader :game_id, :team_id, :hoa, :result, :head_coach, :goals, :shots, :tackles, :pim, :powerPlayOpportunities, :faceOffWinPercentage, :giveaways, :takeaways

  def initialize(game_id, team_id, hoa, result, head_coach, goals, shots, tackles, pim, powerPlayOpportunities, faceOffWinPercentage, giveaways, takeaways)
    @game_id = game_id
    @team_id = team_id
    @hoa = hoa
    @result = result
    @head_coach = head_coach
    @goals = goals
    @shots = shots
    @tackles = tackles
    @pim = pim
    @powerPlayOpportunities = powerPlayOpportunities
    @faceOffWinPercentage = faceOffWinPercentage
    @giveaways = giveaways
    @takeaways = takeaways
  end
end


