class Games
  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link

  def initialize(games_params)
    @game_id = games_params[:game_id]
    @season = games_params[:season]
    @type = games_params[:type]
    @date_time = games_params[:date_time]
    @away_team_id = games_params[:away_team_id]
    @home_team_id = games_params[:home_team_id]
    @away_goals = games_params[:away_goals].to_i
    @home_goals = games_params[:home_goals].to_i
    @venue = games_params[:venue]
    @venue_link = games_params[:venue_link]
  end
end
