class GamesManager
  def initialize(data)
    @games = data.games
  end

  def highest_total_score
    scores = @games.max_by do |game|
      game.total_goals
    end
    scores.total_goals
  end

  def lowest_total_score
    scores = @games.min_by do |game|
      game.total_goals
    end
    scores.total_goals
  end

  def count_of_games_by_season
    hash = Hash.new(0)

    @games.each do |game|
      hash[game.season.to_s] += 1
    end
    hash
  end

  def count_goals
    hash = Hash.new(0)
    @games.each do |game|
        hash[game.season.to_s] += game.away_goals + game.home_goals
    end
     hash
  end

  def average_goals_per_game
    total_goals = @games.sum do |game|
                    game.away_goals + game.home_goals
                  end
    (total_goals/(@games.count.to_f)).round(2)
  end

  def average_goals_by_season
    game_season_totals = count_of_games_by_season
    goal_totals = count_goals
    hash = Hash.new(0)
    @games.each do |game|
      hash[game.season.to_s] = (goal_totals[game.season.to_s].to_f/game_season_totals[game.season.to_s].to_f).round(2)
    end
    hash
  end
end
