module Mathable

  def percentage(numerator, denominator, round)
    (numerator.to_f / denominator).round(round)
  end

  def game_stats_for(collection, team_id)
    collection_stats = Hash.new {|hash, key| hash[key] = Hash.new {|hash, key| hash[key] = 0}}
    collection.each do |data, games|
      games.each do |game|
        collection_stats[data][:game_count] += 1
        collection_stats[data][:win_count] += 1 if game.win?(team_id)
      end
    end
    collection_stats
  end

  def percentage_wins_by(category, team_id)
    win_pct_by_category = Hash.new(0)
    category.each do |data, game_stats|
      win_pct_by_category[data] = percentage(game_stats[:win_count], game_stats[:game_count], 2)
    end
    win_pct_by_category
  end

  def goals_scored(amount, team_id)
    if amount == "most"
      games_by_team(team_id).reduce(0) do |goals, game|
        if game.away?(team_id)
          goals = game.away_goals if game.away_goals > goals
        else
          goals = game.home_goals if game.home_goals > goals
        end
        goals
      end
    else
      games_by_team(team_id).reduce(99) do |goals, game|
        if game.away?(team_id)
          goals = game.away_goals if game.away_goals < goals
        else
          goals = game.home_goals if game.home_goals < goals
        end
        goals
      end
    end 
  end

end
