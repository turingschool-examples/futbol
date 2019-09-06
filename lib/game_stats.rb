module GameStats

  def highest_total_score
    highest_game = @games.max_by do |game_id, game|
      game.away_goals + game.home_goals
    end[1]

    highest_game.away_goals + highest_game.home_goals
  end

  def lowest_total_score
    lowest_game = @games.min_by do |game_id, game|
      game.away_goals + game.home_goals
    end[1]

    lowest_game.away_goals + lowest_game.home_goals
  end

  def biggest_blowout
    blowout_game = @games.max_by do |game_id, game|
      (game.home_goals - game.away_goals).abs
    end[1]

    (blowout_game.home_goals - blowout_game.away_goals).abs
  end

  def percentage_home_wins
    home_wins = @games.count do |game_id, game|
      game.home_goals > game.away_goals
    end

    (home_wins / @games.length.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |game_id, game|
      game.away_goals > game.home_goals
    end

    (visitor_wins / @games.length.to_f).round(2)
  end

  def percentage_ties
    ties = @games.count do |game_id, game|
      game.away_goals ==  game.home_goals
    end

    (ties / @games.length.to_f).round(2)
  end
  
  def count_of_games_by_season
    count = Hash.new(0)

    @games.each do |game_id, game|
      count[game.season] += 1
    end

    count
  end

  def average_goals_per_game
    home_goals = @games.sum {|game| game.home_goals}
    away_goals = @games.sum {|game| game.away_goals}
    total_games = @games.length
    ((home_goals + away_goals).to_f / total_games).round(2)
  end

  def average_goals_by_season
    avg_goals = Hash.new(0)
    seasons = (@games.map {|game| game.season}).uniq
    seasons.each do |season|
      home_goals = 0
      @games.each do |game|
        if game.season == season
          home_goals += game.home_goals
        end
      end
      away_goals = 0
      @games.each do |game|
        if game.season == season
          away_goals += game.away_goals
        end
      end
      total_games = @games.find_all {|game| game.season == season}.length
      season_avg_goals = ((home_goals + away_goals).to_f / total_games).round(2)
      avg_goals[season] = season_avg_goals
    end
    avg_goals
  end
end
