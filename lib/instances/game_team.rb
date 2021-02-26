require_relative '../tables/game_team_tables'


class GameTeam
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
  def initialize(data)
    #data
    @game_id = data[:game_id]
    @team_id = data[:team_id]
    @HoA = data[:HoA]
    @result = data[:result]
    @settled_in = data[:settled_in]
    @head_coach = data[:head_coach]
    @goals = data[:goals]
    @shots = data[:shots]
    @tackles= data[:tackles]
    @pim = data[:pim]
    @powerPlayOpportunities = data[:powerPlayOpportunities]
    @powerPlayGoals = data[:powerPlayGoals]
    @faceOffWinPercentage = data[:faceOffWinPercentage]
    @giveaways = data[:giveaways]
    @takeaways = data[:takeaways]
  end
end
