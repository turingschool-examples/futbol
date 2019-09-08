module TeamStats
  require 'pry'

  def best_season(team_id)
    team_id = team_id.to_i
    team_games = @games.find_all {|game_id, game| game.home_team_id == team_id || game.away_team_id == team_id}
    seasons = []
    team_games.each do |game_id, game|
      seasons << game.season
    end
    seasons = seasons.uniq
    season = Hash.new
    seasons.each do |season_id|
      season[season_id] = {season_wins: 0, season_games: 0}
    end
    team_games.each do |game_id, game|
      season[game.season][:season_games] += 1
      if game.home_team_id == team_id && game.home_goals > game.away_goals
        season[game.season][:season_wins] += 1
      elsif game.away_team_id == team_id && game.away_goals > game.home_goals
        season[game.season][:season_wins] += 1
      end
    end
    #binding.pry
    best_season = ""
    best_season_percent = 0.0
    seasons.each do |season_id|
      season_percent = (season[season_id][:season_wins] / season[season_id][:season_games].to_f) * 100
      if season_percent > best_season_percent
        best_season = season_id
        best_season_percent = season_percent
      end
    end
    best_season
  end

  def worst_season(team_id)
    team_id = team_id.to_i
    team_games = @games.find_all {|game_id, game| game.home_team_id == team_id || game.away_team_id == team_id}
    seasons = []
    team_games.each do |game_id, game|
      seasons << game.season
    end
    seasons = seasons.uniq
    season = Hash.new
    seasons.each do |season_id|
      season[season_id] = {season_wins: 0, season_games: 0}
    end
    team_games.each do |game_id, game|
      season[game.season][:season_games] += 1
      if game.home_team_id == team_id && game.home_goals > game.away_goals
        season[game.season][:season_wins] += 1
      elsif game.away_team_id == team_id && game.away_goals > game.home_goals
        season[game.season][:season_wins] += 1
      end
    end
    #binding.pry
    worst_season = ""
    worst_season_percent = 101
    seasons.each do |season_id|
      season_percent = (season[season_id][:season_wins] / season[season_id][:season_games].to_f) * 100
      if season_percent < worst_season_percent
        worst_season = season_id
        worst_season_percent = season_percent
      end
    end
    worst_season
  end

  def average_win_percentage(team_id)
    #
  end
end
