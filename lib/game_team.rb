require_relative 'classes'

class GameTeam
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
              :powerplayopportunities,
              :powerplaygoals,
              :faceoffwinpercentage,
              :giveaways,
              :takeaways
  def initialize(info)
    @game_id = info["game_id"].to_i
    @team_id = info["team_id"]
    @hoa = info["HoA"]
    @result = info["result"]
    @settled_in = info["settled_in"]
    @head_coach = info["head_coach"]
    @goals = info["goals"].to_i
    @shots = info["shots"].to_i
    @tackles = info["tackles"].to_i
    @pim = info["pim"].to_i
    @powerplayopportunities = info["powerPlayOpportunities"].to_i
    @powerplaygoals = info["powerPlayGoals"].to_i
    @faceoffwinpercentage = info["faceOffWinPercentage"].to_i
    @giveaways = info["giveaways"].to_i
    @takeaways = info["takeaways"].to_i
  end
end