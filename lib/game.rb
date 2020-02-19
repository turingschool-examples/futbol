class Game
  attr_reader :id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link


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

  def total_goals
    @home_goals + @away_goals
  end

  def home_win?
    @home_goals > @away_goals
  end

  def away_win?
    @home_goals < @away_goals
  end

  def tie?
    @home_goals == @away_goals
  end

end
