class GameTeam
  attr_reader :game_id, :team_id, :home_or_away, :result, :settled_in, :head_coach,
              :goals, :shots, :tackles, :pim, :power_play_opportunities,
              :power_play_goals, :face_of_win_percentage, :giveaways, :takeaways

  def initialize(game_team_params)
    @game_id = game_team_params[:game_id].to_i
    @team_id = game_team_params[:team_id].to_i
    @home_or_away = game_team_params[:HoA]
    @result = game_team_params[:result]
    @settled_in = game_team_params[:settled_in]
    @head_coach = game_team_params[:head_coach]
    @goals = game_team_params[:goals].to_i
    @shots = game_team_params[:shots].to_i
    @tackles = game_team_params[:tackles].to_i
    @pim = game_team_params[:pim].to_i
    @power_play_opportunities = game_team_params[:powerPlayOpportunities].to_i
    @power_play_goals = game_team_params[:powerPlayGoals].to_i
    @face_of_win_percentage = game_team_params[:faceOffWinPercentage].to_f
    @giveaways = game_team_params[:giveaways].to_i
    @takeaways = game_team_params[:takeaways].to_i
  end

end
