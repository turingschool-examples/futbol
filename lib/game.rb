class Game

  def initialize(game_params)
    @id             = game_params[:id]
    @season         = game_params[:season]
    @type           = game_params[:type]
    @date_time      = game_params[:date_time]
    @away_team_id   = game_params[:away_team_id]
    @home_team_id   = game_params[:home_team_id]
    @away_goals     = game_params[:away_goals]
    @home_goals     = game_params[:home_goals]
    @venue          = game_params[:venue]
    @venue_link     = game_params[:venue_link]
  end

  

end
