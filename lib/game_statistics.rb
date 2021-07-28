module GameStatistics

  def highest_total_scores
    highest = 0
    @games.each do |game|
      sum = game[:away_goals].to_i + game[:home_goals].to_i
      highest = sum if sum > highest
    end
    highest
  end

  def lowest_total_scores
    lowest = games.first[:away_goals].to_i + games.first[:home_goals].to_i
    @games.each do |game|
      sum = game[:away_goals].to_i + game[:home_goals].to_i
      lowest = sum if sum < lowest
    end
    lowest
  end

  def percentage_home_wins
    home_games = 0
    home_wins = 0
    @game_teams.each do |game_team|
      if game_team[:hoa] == 'home'
        home_games += 1
        if game_team[:result] == 'WIN'
          home_wins += 1
        end
      end
    end
    ((home_wins.to_f / home_games.to_f) * 100).round(2)
  end

  def percentage_visitor_wins
    visitor_games = 0
    visitor_wins = 0
    @game_teams.each do |game_team|
      if game_team[:hoa] == 'away'
        visitor_games += 1
        if game_team[:result] == 'WIN'
          visitor_wins += 1
        end
      end
    end
    ((visitor_wins.to_f /  visitor_games.to_f) * 100).round(2)
  end

  def percentage_ties
    ties = 0
    @games.each do |game|
      if game[:home_goals] == game[:away_goals]
        ties += 1
      end
    end
    ((ties.to_f / @games.count.to_f) * 100).round(2)
  end

  def count_of_games_by_season
    games_by_season = {}
    @games.each do |game|
      if games_by_season[game[:season]].nil?
        games_by_season[game[:season]] = 1
      else
        games_by_season[game[:season]] += 1
      end
    end
    games_by_season
  end

  def total_games
    @games.count
  end

  def total_goals
    goals_scored = 0
    @games.each do |game|
      goals_scored += (game[:away_goals].to_i + game[:home_goals].to_i)
    end
    goals_scored
  end

  def average_goals_per_game
    (total_goals / total_games.to_f).round(2)
  end

  # def total_goals_per_season(season)
  #   goals = 0
  #   @games.each do |game|
  #     if game[:season] == season
  #       goals += (game[:away_goals].to_i + game[:home_goals].to_i)
  #     end
  #   end
  #   goals
  # end
  #
  # def total_games_per_season(season)
  #   total_season_games = 0
  #   @games.each do |game|
  #     total_season_games += 1 if game[:season] == season
  #   end
  #   total_season_games
  # end

  def average_goals_by_season
    season_data = {}
    @games.each do |game|
      if season_data[game[:season]].nil?
        season_data[game[:season]] = {
          :total_season_games => 1,
          :total_goals_season => (game[:away_goals].to_i + game[:home_goals].to_i)
        }
      else
        season_data[game[:season]][:total_season_games] += 1
        season_data[game[:season]][:total_goals_season] += (game[:away_goals].to_i + game[:home_goals].to_i)
      end
    end
    average_goals_by_season = {}
    season_data.each do |season, data|
      average_goals_by_season[season] = (data[:total_goals_season].to_f / data[:total_season_games]).round(2)
    end
    average_goals_by_season
  end
end
