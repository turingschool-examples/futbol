class GameTeamsMethods
attr_reader :game_teams, :game_teams_table
  def initialize(game_teams)
    @game_teams = game_teams
    @game_teams_table = create_table(@game_teams)
  end

  def create_table(file)
    CSV.parse(File.read(file), headers: true)
  end

  def best_offense_team_id_average_goal
    team_averages = average_goals_by_team
    team_id = team_averages.max_by do |key, value|
      value
    end
  end
end
