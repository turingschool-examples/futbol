class GameStats
  attr_reader :game_collection

  def initialize(game_collection)
    @game_collection = game_collection
  end

  def average_goals(array)
    total_goals = array.reduce(0) do |sum, game|
      sum += game.total_score
      sum
    end
    (total_goals.to_f / array.length).round(2)
  end

  def average_goals_per_game
    average_goals(@game_collection.games)
  end

  def average_goals_by_season
    season_hash = @game_collection.game_lists_by_season
    season_hash.each do |key, value|
      season_hash[key] = average_goals(value)
    end
  end

  def percentage_home_wins
    home_wins = @game_collection.games.count do |game|
      game.home_goals > game.away_goals
    end
    (home_wins.to_f / @game_collection.games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @game_collection.games.count do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.to_f / @game_collection.games.length).round(2)
  end

  def percentage_ties
    ties_count = @game_collection.games.count do |game|
      game.home_goals == game.away_goals
    end
    (ties_count.to_f / @game_collection.games.length).round(2)
  end

  def highest_total_score
    highest_score = @game_collection.games.max_by do |game|
      game.total_score
    end.total_score
    highest_score
  end

  def lowest_total_score
    lowest_score = @game_collection.games.min_by do |game|
      game.total_score
    end.total_score
    lowest_score
  end

  def biggest_blowout
    games_difference = @game_collection.games.max_by do |game|
      game.difference_between_score
    end.difference_between_score
    games_difference
  end
end
