require 'CSV'


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
    @row = row["game_id"]
    @team_id = row["team_id"]
    @HoA = row["HoA"]
    @result = row["result"]
    @settled_in = row["settled_in"]
    @head_coach = row["head_coach"]
    @goals = row["goals"]
    @shots = row["shots"]
    @tackles = row["tackle"]
    @pim = row["pim"]
    @powerPlayOpportunities = row["powerPlayOpportunities"]
    @powerPlayGoals = row["powerPlayGoals"]
    @faceOffWinPercentage = row["faceOffWinPercentage"]
    @giveaways = row["giveaways"]
    @takeaways = row["takeaways"]

  end
end
