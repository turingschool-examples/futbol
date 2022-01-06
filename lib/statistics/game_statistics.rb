class GameStatistics
  attr_reader :games

  def initialize(game_manager)
    @games = game_manager
  end

  def highest_total_score
    game_with_highest_total_score = games.data.max_by do |game|
      game.total_score
    end
    game_with_highest_total_score.total_score
  end

  def lowest_total_score
    game_with_lowest_total_score = games.data.min_by do |game|
      game.total_score
    end
    game_with_lowest_total_score.total_score
  end

  def percentage_home_wins
    home_wins = games.data.find_all do |game|
      game.home_win?
    end.count
    game_count = games.data.count
    (home_wins.to_f / game_count.to_f).round(5) * 100
  end
end
