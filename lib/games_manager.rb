class GamesManager
  def initialize(games)
    @games = games
  end

  def self.from_csv(locations)
    games_path = locations[:games]
  end

  def self.highest_total_score(path)
    scores = path.max_by do |game|
      game.total_goals
    end
    scores.total_goals
  end

  def self.lowest_total_score(path)
    scores = path.min_by do |game|
      game.total_goals
    end
    scores.total_goals
  end
end
