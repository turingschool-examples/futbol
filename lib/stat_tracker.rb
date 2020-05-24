class StatTracker

  attr_reader :games,
              :teams,
              :game_teams

  def self.from_csv(path)
    @games = path[:games]
    @teams = path[:teams]
    @game_teams = path[:game_teams]
  end

end
