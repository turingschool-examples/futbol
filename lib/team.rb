class Team
  attr_reader :team_general_info,
              :games_by_team,
              :team_id,
              :team_name
  def initialize(team_general_info, games_by_team)
    @team_id = team_general_info[:team_id]
    @team_name = team_general_info[:teamname]
    @team_general_info = team_general_info
    @games_by_team = games_by_team
  end
end