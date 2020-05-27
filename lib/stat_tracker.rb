class StatTracker
  attr_reader :games_file_path, :teams_file_path, :game_teams_file_path

  def initialize(argument)
    @games_file_path
    @teams_file_path
    @game_teams_file_path
  end

  def self.from_csv(locations)
    games_file_path = locations[:games]
    teams_file_path = locations[:teams]
    game_teams_file_path = locations[:game_teams]
    StatTracker.new
  end
end
