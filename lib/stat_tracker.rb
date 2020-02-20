class StatTracker

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]

    StatTracker.new(game_path, team_path, game_teams_path)
  end

  attr_reader :game_path, :team_path, :game_teams_path
  def initialize(game_path, team_path, game_teams_path)
    @games = Game.create_all(game_path)
    @team_path = team_path
    @game_teams_path = game_teams_path
  end
end
