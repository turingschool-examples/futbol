class GameStats
  attr_reader :game_id, :team_id, :HoA, :result, :settled_in, :head_coach,
              :goals, :shots, :tackles, :pim, :powerPlayOpportunities,
              :powerPlayGoals, :faceOffWinPercentage, :giveaways, :takeaways

  def initialize(game_stats)
    @game_id = game_stats[:game_id]
    @team_id = game_stats[:team_id]
    @HoA = game_stats[:HoA]
    @result = game_stats[:result]
    @settled_in = game_stats[:settled_in]
    @head_coach = game_stats[:head_coach]
    @goals = game_stats[:goals]
    @shots = game_stats[:shots]
    @tackles = game_stats[:tackles]
    @pim = game_stats[:pim]
    @powerPlayOpportunities = game_stats[:powerPlayOpportunities]
    @powerPlayGoals = game_stats[:powerPlayGoals]
    @faceOffWinPercentage = game_stats[:faceOffWinPercentage]
    @giveaways = game_stats[:giveaways]
    @takeaways = game_stats[:takeaways]
  end
end
