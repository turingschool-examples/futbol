module Helpable

  def game_score_totals_sorted
    games.map do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end.sort
  end

  def home_wins
    home_wins = games.count do |game|
      game.home_goals.to_i > game.away_goals.to_i
    end
  end

  def away_wins
    away_wins = games.count do |game|
      game.away_goals.to_i > game.home_goals.to_i
    end
  end

  def tie_games
    ties = games.count do |game|
      game.away_goals.to_i == game.home_goals.to_i
    end
  end

  def goals_per_game(game)
    game.away_goals.to_i + game.home_goals.to_i
  end

  def goals_per_season(season, num_games)
    goal_counter = 0
    games.each do |game|
      if game.season == season
        goal_counter += goals_per_game(game)
      end
    end
    goal_counter
  end

  def team_score_averages
    team_id_hash = Hash.new{|h,v| h[v] = []}
    games.each do |game|
      team_id_hash[game.away_team_id] << game.away_goals.to_f
      team_id_hash[game.home_team_id] << game.home_goals.to_f
    end

    goal_average_hash = Hash.new
    team_id_hash.each do |team_id, score_array|
      goal_average_hash[team_id] = (score_array.sum / score_array.size).round(4)
    end

    goal_average_hash.sort_by{|key, value| value}
  end

  def visitor_score_averages
    team_id_hash = Hash.new{|h,v| h[v] = []}
    games.each do |game|
      team_id_hash[game.away_team_id] << game.away_goals.to_f
    end

    average_hash = Hash.new
    team_id_hash.each do |team_id, score_array|
      average_hash[team_id] = (score_array.sum / score_array.size).round(4)
    end

    average_hash.sort_by{|key, value| value}
  end

  def home_score_averages
    team_id_hash = Hash.new{|h,v| h[v] = []}
    games.each do |game|
      team_id_hash[game.home_team_id] << game.home_goals.to_f
    end
    average_hash = Hash.new
    team_id_hash.each do |team_id, score_array|
      average_hash[team_id] = (score_array.sum / score_array.size).round(4)
    end
    average_hash.sort_by{|key, value| value}
  end

  def array_of_gameids_by_season(season)
    games_by_season = games.find_all do |game|     
      game.season == season
    end

    game_ids_arr = games_by_season.map do |game|
      game.game_id
    end
  end

  def array_of_game_teams_by_season(season)
    game_teams_arr = []
    array_of_gameids_by_season(season).each do |game_id|
      game_teams.each do |game_team|
        game_teams_arr << game_team if game_team.game_id == game_id
      end
    end
    game_teams_arr
  end

  def coaches_win_percentages_hash(season)
    coaches_hash = Hash.new{|h,v| h[v] = []}
    array_of_game_teams_by_season(season).each do |game_team|
      coaches_hash[game_team.head_coach] << game_team.result
    end

    coaches_hash.each do |coach, result_arr|
      percent = (result_arr.count("WIN").to_f/result_arr.size)*100
      coaches_hash[coach] = percent
    end
  end

  def goals_scored_sorted(teamid)
    game_scores = []

    games.each do |game|
      game_scores << game.home_goals.to_i if game.home_team_id == teamid
      game_scores << game.away_goals.to_i if game.away_team_id == teamid
    end
    game_scores.sort
  end

  def find_team_id(team_id)
    teams.find do |team|
      team.team_id == team_id
    end
  end

  def team_ratio_hash(season)
    goals_hash = {}
    shots_hash = {}
    team_ratio_hash = {}

    season_games = game_teams.find_all do |game_team|
      game_team.game_id[0..3] == season[0..3]
    end

    season_games.each do |game_team|
      goals_hash[game_team.team_id] = 0
      shots_hash[game_team.team_id] = 0
    end
    season_games.each do |game_team|
      goals_hash[game_team.team_id] += game_team.goals.to_i
      shots_hash[game_team.team_id] += game_team.shots.to_i
    end

    goals_hash.each do |team, goals|
      team_ratio_hash[team] = goals.to_f/shots_hash[team]
    end
    team_ratio_hash
  end

  def find_game_id_arr(team_id)
    all_games = game_teams.find_all do |team|
      team.team_id == team_id
    end

    all_games.map do |game|
      game.game_id
    end
  end

  def opponents_win_percentage(team_id)
    opponents_wins = Hash.new{ |h,v| h[v] = [] }
    find_game_id_arr(team_id).each do |game_id|
      game_teams.each do |game_team|
        opponents_wins[game_team.team_id] << game_team.result if game_team.game_id == game_id && game_team.team_id != team_id
      end
    end

    opponents_wins.each do |team_id, result_array|
      percent = result_array.count("WIN").to_f / result_array.size
      opponents_wins[team_id] = percent
    end
    opponents_wins.sort_by{|k,v| v}
  end

  def find_team_name(team_id)
    teams.each do |team|
      return team.team_name if team.team_id == team_id
    end
  end

  def game_ids_seasons(team_id)
    seasons_hash = Hash.new{|h,v| h[v] = []}
    games.each do |game| 
      seasons_hash[game.season] << game.game_id
    end  
    seasons_hash
  end

  def seasons_perc_win(team_id)
    wins_by_seasons = Hash.new{|h,v| h[v] = []}
    game_ids_seasons = game_ids_seasons(team_id)
    game_ids_seasons.each do |season, game_ids_arr| 
      game_ids_arr.each do |game_id|
        game_teams.each do |game_team| 
          wins_by_seasons[season] << game_team.result if game_id == game_team.game_id && team_id == game_team.team_id
        end
      end
    end
    wins_by_seasons.each do |season, array|
      wins_by_seasons[season] = (array.count("WIN")/ array.size.to_f) 
    end
    wins_by_seasons.sort_by { |k, v| v }
  end
end  