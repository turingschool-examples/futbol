require 'csv'
require 'simplecov'

SimpleCov.start

class GameTeamStats
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

  def initialize(game_team_data)
    @game_id                = game_team_data["game_id"]
    @team_id                = game_team_data["team_id"]
    @HoA                    = game_team_data["HoA"]
    @result                 = game_team_data["result"]
    @settled_in             = game_team_data["settled_in"]
    @head_coach             = game_team_data["head_coach"]
    @goals                  = game_team_data["goals"]
    @shots                  = game_team_data["shots"]
    @tackles                = game_team_data["tackles"]
    @pim                    = game_team_data["pim"]
    @powerPlayOpportunities = game_team_data["powerPlayOpportunities"]
    @powerPlayGoals         = game_team_data["powerPlayGoals"]
    @faceOffWinPercentage   = game_team_data["faceOffWinPercentage"]
    @giveaways              = game_team_data["giveaways"]
    @takeaways              = game_team_data["takeaways"]
  end
end