class Team
  attr_reader :team_general_info,
              :games_by_team
  def initialize(team_general_info, games_by_team)
    @team_general_info = team_general_info
    @games_by_team = games_by_team
  end
end