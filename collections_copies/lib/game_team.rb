class GameTeam
  attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals, :shots, :tackles, :pim, :powerPlayOpportunities, :powerPlayGoals, :faceOffWinPercentage, :giveaways, :takeaways

  def initialize(game_id,team_id,hoa,result,settled_in,head_coach,goals,shots,tackles,pim,powerPlayOpportunities,powerPlayGoals,faceOffWinPercentage,giveaways,takeaways)
    @game_id = game_id.to_i
    @team_id = team_id.to_i
    @hoa = hoa
    @result = result
    @settled_in = settled_in
    @head_coach = head_coach
    @goals = goals.to_i
    @shots = shots.to_i
    @tackles = tackles.to_i
    @pim = pim.to_i
    @powerPlayOpportunities = powerPlayOpportunities.to_i
    @powerPlayGoals = powerPlayGoals.to_i
    @faceOffWinPercentage = faceOffWinPercentage.to_f
    @giveaways = giveaways.to_i
    @takeaways = takeaways.to_i
  end
end
