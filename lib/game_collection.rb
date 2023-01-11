require_relative '../lib/game'

module GameCollection

  def total_score(game_collection)
    game_collection.map do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end
  end
  
  def home_wins(game_collection)
    game_collection.find_all do |game|
      game.home_goals.to_i > game.away_goals.to_i
    end
  end

  def visitor_wins(game_collection)
    game_collection.find_all do |game|
      game.home_goals.to_i < game.away_goals.to_i
    end
  end
  
  def ties(game_collection)
    game_collection.find_all do |game|
      game.home_goals.to_i == game.away_goals.to_i
    end
  end
  
  def count_of_games(game_collection)
    count_of_games_by_season = Hash.new {0}

    game_collection.each do |game|
      count_of_games_by_season[(game.season)] += 1
    end

    count_of_games_by_season
  end

  def add_total_away_score_and_away_games(teams_total_scores, teams_total_games)
    # find_average(@game_teams_array, teams_total_scores, teams_total_games, team_id, goals)

    @games_array.each do |game|
      teams_total_scores[game.away_team_id] += game.away_goals.to_f
      teams_total_games[game.away_team_id] += 1.0
    end
  end
  
  def averages_of_goals_per_game(game_collection)
    sums = game_collection.map do |game|
      game.away_goals.to_f + game.home_goals.to_f
    end
  
    total_average = (sums.sum/game_collection.count).round(2)
  end

  def average_goals_by_seasons(game_collection)
    average_goals_by_season = Hash.new{|k,v| k[v] = 0} 
    total_goals_by_season = Hash.new{|k,v| k[v] = 0}
  
    game_collection.each do |game|
      total_goals_by_season[game.season] += game.away_goals.to_f + game.home_goals.to_f
      # if total_goals_by_season[(game.season)] == nil
      #   total_goals_by_season[(game.season)] = game.away_goals.to_f + game.home_goals.to_f
      # else
      #   total_goals_by_season[(game.season)] += game.away_goals.to_f + game.home_goals.to_f
      # end
    end

    total_goals_by_season.each do |season, total_goals|
      average_goals_by_season[season] = (total_goals/count_of_games(game_collection)[season]).round(2)
    end
    
    average_goals_by_season
  end

	


  def add_total_home_score_and_home_games(teams_total_scores, teams_total_games)
    # find_average(@game_teams_array, teams_total_scores, teams_total_games, team_id, goals)

    @games_array.each do |game|
      teams_total_scores[game.home_team_id] += game.home_goals.to_f
      teams_total_games[game.home_team_id] += 1.0
    end
  end

  

	def game_ids_by_season
    game_ids_by_season = Hash.new{|k,v| k[v] = []} 

		@games_array.each do |game|
			game_ids_by_season[(game.season)] << (game.game_id)
    end

		game_ids_by_season
  end
end