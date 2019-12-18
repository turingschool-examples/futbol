class StatTracker

  attr_reader :game_teams_path, :game_path, :teams_path

  def self.from_csv(locations)
    game_teams_path = locations[:game_teams]
    game_path = locations[:games]
    teams_path = locations[:teams]

    StatTracker.new(game_teams_path, game_path, teams_path)
  end

  def initialize(game_teams_path, game_path, teams_path)
    @game_teams_path = game_teams_path
    @game_path = game_path
    @teams_path = teams_path
  end
end
