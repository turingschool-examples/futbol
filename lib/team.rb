require 'csv'

class Team
  def initialize(team_params)
    @team_id = team_params[:team_id]
    @franchise_id = team_params[:franchise_id]
    @team_name = team_params[:team_name]
    @abbreviation = team_params[:abbreviation]
    @link = team_params[:link]
  end
end
