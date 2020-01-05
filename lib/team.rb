class Team

attr_reader  :franchise_id, :team_name, :abbreviation, :link

  def initialize(team)
    @team = {team_id: team[:team_id], franchise_id: team[:franchise_id], team_name: team[:team_name], abbreviation: team[:abbreviation], link: team[:link]}
  end
end 
