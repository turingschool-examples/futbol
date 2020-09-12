class GameManager
  def initialize()
  def highest_total_score
    highest_score = highest_total_score_helper
    highest_score.away_goals + highest_score.home_goals
  end

  def highest_total_score_helper
    @games.max_by do |game|
      game.away_goals + game.home_goals
    end
  end

  def lowest_total_score
    min_score = lowest_total_score_helper
    min_score.away_goals + min_score.home_goals
  end

  def lowest_total_score_helper
    @games.min_by do |game|
      game.away_goals + game.home_goals
    end
  end

  def percentage_home_wins
    percent_wins = percentage_home_win_helper
    (percent_wins / @games.length.to_f).round(2)
  end

  def percentage_home_win_helper
    @games.count do |game|
      game.home_goals > game.away_goals
    end
  end

  def percentage_visitor_wins
    percent_wins = percentage_visitor_win_helper
    (percent_wins / @games.length.to_f).round(2)
  end

  def percentage_visitor_win_helper
    @games.count do |game|
      game.home_goals < game.away_goals
    end
  end

  def percentage_ties
    percent_ties = percentage_ties_helper
    (percent_ties / @games.length.to_f).round(2)
  end

  def percentage_ties_helper
    @games.count do |game|
      game.home_goals == game.away_goals
    end
  end

  def count_of_games_by_season
    seasons = []
    seasons_hash = {}
    @games.each do |game|
      seasons << game.season unless seasons.include? game.season
    end
    seasons.each do |season|
      seasons_hash[season] = @games.count { |game| game.season == season }
    end
    seasons_hash
  end

  def average_goals_per_game
    total = 0
    @games.each do |game|
      average_goals = (game.away_goals + game.home_goals) / @games.length.to_f
      total += average_goals
    end
    total.round(2)
  end

  def group_by_season
    @games.group_by do |game|
      game.season
    end.uniq
  end

  def average_goals_by_season
    # seasons_hash = {}
    # group_by_season.each do |season|
    #   total = 0
    #   season[1].each do |game|
    #     total += game.away_goals + game.home_goals
    #   end
    #   seasons_hash[season[0]] = (total/season[1].length.to_f).round(2)
    # end
    # seasons_hash
    group_by_season.reduce({}) do |season_hash, season|
      season_hash[season[0]] = (season[1].sum { |game| game.away_goals + game.home_goals} / season[1].length.to_f).round(2))
    end
  end
end


users = []
users.reduce({}) do |hash, user|
  hash[user.name] = user.age
end