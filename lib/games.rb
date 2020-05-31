class Games
  attr_reader :game_id,
              :season,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(games_params)
    @game_id = games_params[:game_id]
    @season = games_params[:season]
    @away_team_id = games_params[:away_team_id]
    @home_team_id = games_params[:home_team_id]
    @away_goals = games_params[:away_goals].to_i
    @home_goals = games_params[:home_goals].to_i
  end

end
