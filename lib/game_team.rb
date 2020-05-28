class GameTeam ### clean out data that is not necessary to store 
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

  def initialize(game_teams_data)
    @game_id = game_teams_data[:game_id].to_i
    @team_id = game_teams_data[:team_id].to_i
    @hoa = game_teams_data[:hoa]
    @result = game_teams_data[:result]
    @settled_in = game_teams_data[:settled_in]
    @head_coach = game_teams_data[:head_coach]
    @goals = game_teams_data[:goals].to_i
    @shots = game_teams_data[:shots].to_i
    @tackles = game_teams_data[:tackles].to_i
    @pim = game_teams_data[:pim].to_i
    @powerPlayOpportunities = game_teams_data[:powerPlayOpportunities].to_i
    @powerPlayGoals = game_teams_data[:powerPlayGoals].to_i
    @faceOffWinPercentage = game_teams_data[:faceOffWinPercentage].to_f
    @giveaways = game_teams_data[:giveaways].to_i
    @takeaways = game_teams_data[:takeaways].to_i
  end
end
