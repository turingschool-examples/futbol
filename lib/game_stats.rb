class GameStats
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
              :powerPlayOpportunities,
              :powerPlayGoals,
              :faceOffWinPercentage,
              :giveaways,
              :takeaways

  def initialize(stats)
    @game_id = stats[:game_id]
    @team_id = stats[:team_id]
    @hoa = stats[:hoa]
    @result = stats[:result]
    @settled_in = stats[:settled_in]
    @head_coach = stats[:head_coach]
    @goals = stats[:goals]
    @shots = stats[:shots]
    @tackles = stats[:tackles]
    @pim = stats[:pim]
    @powerPlayOpportunities = stats[:powerPlayOpportunities]
    @powerPlayGoals = stats[:powerPlayGoals]
    @faceOffWinPercentage = stats[:faceOffWinPercentage]
    @giveaways = stats[:giveaways]
    @takeaways = stats[:takeaways]
  end
end
