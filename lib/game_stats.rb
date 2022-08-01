module GameStats
  def highest_total_score
    score_crawler[1]
  end

  def lowest_total_score
    score_crawler[0]
  end

  def score_crawler
    @games.map { |game| [game[:away_goals], game[:home_goals]].sum(&:to_i) }.minmax
  end

  def percentage_home_wins
    (@games.count { |game| game_comp(game).positive? } / total_games).round(2)
  end

  def percentage_visitor_wins
    (@games.count { |game| game_comp(game).negative? } / total_games).round(2)
  end

  def percentage_ties
    (@games.count { |game| game_comp(game).zero? } / total_games).round(2)
  end

  def game_comp(game)
    game[:home_goals].to_i - game[:away_goals].to_i
  end

  def total_games
    @games.count.to_f
  end

  def count_of_games_by_season(team_id = false)
    @games.reduce(Hash.new(0)) do |hash, game|
      hash[game[:season]] += 1 if team_id == false || (team_id == game[:home_team_id || :away_team_id])
      hash
    end
  end

  def average_goals_per_game
    (@games.sum { |game| game[:away_goals].to_f + game[:home_goals].to_f } / @games.count).round(2)
  end

  def average_goals_by_season
    goals = @games.reduce(Hash.new(0)) do |hash, game|
      hash[game[:season]] += [game[:away_goals], game[:home_goals]].sum(&:to_i)
      hash
    end
    Hash[goals.map { |k, v| [k, (v / count_of_games_by_season[k].to_f).round(2)] }]
  end
end

