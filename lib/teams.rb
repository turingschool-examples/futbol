class Teams
  attr_reader :team_id,
              :teamname,
              :abbreviation

  def initialize(teams_params)
    @team_id = teams_params[:team_id]
    @teamname = teams_params[:teamname]
    @abbreviation = teams_params[:abbreviation]
  end
end
