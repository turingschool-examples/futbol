class Team

  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :link

  def initialize(team_param)
    @team_id = team_param[:team_id]
    @franchise_id = team_param[:franchiseid]
    @team_name = team_param[:teamname]
    @abbreviation = team_param[:abbreviation]
    @link = team_param[:link]
  end

end
