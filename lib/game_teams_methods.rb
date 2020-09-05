class GameTeamsMethods
attr_reader :game_teams, :game_teams_table
  def initialize(game_teams)
    @game_teams = game_teams
    @game_teams_table = create_table(@game_teams)
  end

  def create_table(file)
    CSV.parse(File.read(file), headers: true)
  end
end
