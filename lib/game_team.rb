class GameTeam
  attr_reader :game_id,
              :team_id,
              :HoA,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :team_id,
              :pim,
              :powerPlayOpportunities,
              :powerPlayGoals,
              :faceOffWinPercentage,
              :giveaways,
              :takeaways
  def initialize(row)
    row.each do |k, v|
      instance_variable_set("@" + k, v)
    end
    @faceOffWinPercentage = @faceOffWinPercentage.to_f
    @giveaways = @giveaways.to_i
    @goals = @goals.to_i
    @pim = @pim.to_i
    @powerPlayGoals = @powerPlayGoals.to_i
    @powerPlayOpportunities = @powerPlayOpportunities.to_i
    @shots = @shots.to_i
    @tackles = @tackles.to_i
    @takeaways = @takeaways.to_i    
  end
end
