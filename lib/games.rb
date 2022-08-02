require './lib/csv_loader'

class Games < CsvLoader

  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def total_scores_by_game #helper for issue #2, #3, #6
    @games.values_at(:away_goals, :home_goals).map do |game|
      game[0] + game[1]
    end
  end

  def highest_total_score #issue #2
    total_scores_by_game.max
  end

end
