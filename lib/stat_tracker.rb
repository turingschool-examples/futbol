class StatTracker
  attr_reader :game_path, :teams_path, :game_teams_path
  def self.from_csv(file_paths)
    game_path = file_paths[:games]
    teams_path = file_paths[:teams]
    game_teams_path = file_paths[:game_teams]
    StatTracker.new(game_path, teams_path, game_teams_path)
  end

  def initialize(game_path, teams_path, game_teams_path)
    @game_path = game_path
    @teams_path = teams_path
    @game_teams_path = game_teams_path
  end

  def games
    Game.from_csv(@game_path)
    Game.all
  end

  def games 
    Team.from_csv(@game_path)
    Team.all
  end

  def count_of_teams
    Team.all.length
  end
end
