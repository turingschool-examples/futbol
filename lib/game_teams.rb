require 'Time'

class GameTeams
  attr_reader :game_id, :team_id, :HoA, :result, :settled_in, :head_coach,
  :goals, :shots, :tackles, :pim, :powerPlayOpportunities, :powerPlayGoals,
  :faceOffWinPercentage, :giveaways, :takeaways

  def initialize(game_team_info)
    @game_id = game_team_info[:game_id].to_i
    @team_id = game_team_info[:team_id].to_i
    @HoA = game_team_info[:HoA]
    @result = game_team_info[:result]
    @settled_in = game_team_info[:settled_in]
    @head_coach = game_team_info[:head_coach]
    @goals = game_team_info[:goals].to_i
    @shots = game_team_info[:shots].to_i
    @tackles = game_team_info[:tackles].to_i
    @pim = game_team_info[:pim].to_i
    @powerPlayOpportunities = game_team_info[:powerPlayOpportunities].to_i
    @powerPlayGoals = game_team_info[:powerPlayGoals].to_i
    @faceOffWinPercentage = game_team_info[:faceOffWinPercentage].to_f
    @giveaways = game_team_info[:giveaways].to_i
    @takeaways = game_team_info[:takeaways].to_i
  end
end
