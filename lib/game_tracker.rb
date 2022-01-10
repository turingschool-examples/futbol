class GameTracker < Statistics

  def highest_total_score
    total_scores = []
    @games.each do |game|
        score =  game.away_goals.to_i + game.home_goals.to_i
        total_scores << score
    end
      total_scores.max
    end


    def lowest_total_score
      total_scores = []
      @games.each do |game|
        score =  game.away_goals.to_i + game.home_goals.to_i
        total_scores << score
      end

      total_scores.min
    end

    def percentage_home_wins
      total_games = 0
      home_wins = 0
      @games.each do |game|
        total_games += 1
        game.home_goals.to_i > game.away_goals.to_i ? home_wins += 1 : next
      end
      ((home_wins.to_f / total_games) * 100).round(2)
    end

    def percentage_vistor_wins
      total_games = 0
      visitor_wins = 0
        @games.each do |game|
        total_games += 1
        game.home_goals.to_i < game.away_goals.to_i ? visitor_wins += 1 : next
      end
      ((visitor_wins.to_f / total_games) * 100).round(2)
    end

    def percentage_ties
      total_games = 0
      ties = 0
      @games.each do |game|
        total_games += 1
        game.home_goals.to_i == game.away_goals.to_i ? ties += 1 : next
      end
      ((ties.to_f / total_games) * 100).round(2)
    end

    def count_of_games_by_season
      game_count = Hash.new(0)
      @games.each do |game|
        game_count[game.season] += 1
      end
      game_count
    end

    def average_goals_per_game
      total_games = 0
      total_scores = 0
      @games.each do |game|
        total_games += 1
        total_scores += (game.home_goals.to_i + game.away_goals.to_i)
      end
      (total_scores.to_f / total_games).round(2)
    end

    def average_goals_by_season
      season_hash = @games.group_by do |game|
        game.season
      end
      average_goals_by_season = season_hash.each_pair do |season, games|
        goal_total = 0
        games.each do |game|
          goal_total += game.home_goals.to_f
          goal_total += game.away_goals.to_f
        end
        season_hash[season] = (goal_total.to_f / games.length)
      end
    end
end
