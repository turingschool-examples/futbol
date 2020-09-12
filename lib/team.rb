class Team
  attr_reader :manager,
              :team_id,
              :team_data,
              :teamname,
              :abbreviation,
              :link

  def initialize(team_data, manager)
    @manager      = manager
    @team_data    = team_data
    @team_id      = team_data[:team_id]
    @teamname     = team_data[:teamname]
    @abbreviation = team_data[:abbreviation]
    @link         = team_data[:link]
  end

  
end
