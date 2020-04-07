class GameStats
  attr_reader :game_id, :team_id, :HoA, :result, :settled_in, :head_coach,
              :goals, :shots, :tackles, :pim, :powerPlayOpportunities,
              :powerPlayGoals, :faceOffWinPercentage, :giveaways, :takeaways

  def initialize(game_stats)
    @game_id = game_stats[:game_id].to_i
    @team_id = game_stats[:team_id].to_i
    @HoA = game_stats[:HoA]
    @result = game_stats[:result]
    @settled_in = game_stats[:settled_in]
    @head_coach = game_stats[:head_coach]
    @goals = game_stats[:goals].to_i
    @shots = game_stats[:shots].to_i
    @tackles = game_stats[:tackles].to_i
    @pim = game_stats[:pim].to_i
    @powerPlayOpportunities = game_stats[:powerPlayOpportunities].to_i
    @powerPlayGoals = game_stats[:powerPlayGoals].to_i
    @faceOffWinPercentage = game_stats[:faceOffWinPercentage].to_f
    @giveaways = game_stats[:giveaways].to_i
    @takeaways = game_stats[:takeaways].to_i
  end
end
