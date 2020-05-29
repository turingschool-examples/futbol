class Team

  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  def initialize(team_params)
    @team_id = team_params[:team_id]
    @franchiseid = team_params[:franchiseid]
    @teamname = team_params[:teamname]
    @abbreviation = team_params[:abbreviation]
    @stadium = team_params[:stadium]
    @link = team_params[:link]
  end
end
