class Team
  attr_reader :team_id,
              :franchiseId,
              :teamName,
              :abbreviation,
              :stadium,
              :link

  def initialize (team_params)
    @team_id        = team_params[:team_id]
    @franchiseId    = team_params[:franchiseId]
    @teamName       = team_params[:teamName]
    @abbreviation   = team_params[:abbreviation]
    @stadium        = team_params[:stadium]
    @link           = team_params[:link]
  end
end
