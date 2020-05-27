class StatTracker
<<<<<<< HEAD
  
=======
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
>>>>>>> 474ae8a71fb19fad81eacf76d9241f1e9d52f3f3
end
