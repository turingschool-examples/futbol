require 'Time'

class GameTeams
  attr_reader :game_id, :team_id, :HoA, :result, :settled_in, :head_coach,
  :goals, :shots, :tackles, :pim, :powerPlayOpportunities, :powerPlayGoals,
  :faceOffWinPercentage, :giveaways, :takeaways

  def initialize(game_teams_info)
    @game_id = game_teams_info[:game_id].to_i
    @team_id = game_teams_info[:team_id].to_i
    @HoA = game_teams_info[:HoA]
    @result = game_teams_info[:result]
    @settled_in = game_teams_info[:settled_in]
    @head_coach = game_teams_info[:head_coach]
    @goals = game_teams_info[:goals].to_i
    @shots = game_teams_info[:shots].to_i
    @tackles = game_teams_info[:tackles].to_i
    @pim = game_teams_info[:pim].to_i
    @powerPlayOpportunities = game_teams_info[:powerPlayOpportunities].to_i
    @powerPlayGoals = game_teams_info[:powerPlayGoals].to_i
    @faceOffWinPercentage = game_teams_info[:faceOffWinPercentage].to_f
    @giveaways = game_teams_info[:giveaways].to_i
    @takeaways = game_teams_info[:takeaways].to_i
  end
end
