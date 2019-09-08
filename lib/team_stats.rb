module TeamStats

  def most_goals_scored(team_id)
    team_id = team_id.to_i
    most_goals = 0
    @game_teams.each do |game_id, game_teams|
      game_teams.each do |game_team|
        if game_team.team_id == team_id
          most_goals = game_team.goals if game_team.goals > most_goals
        end
      end
    end
    most_goals
  end

  def fewest_goals_scored(team_id)
    team_id = team_id.to_i
    fewest_goals = 50
    @game_teams.each do |game_id, game_teams|
      game_teams.each do |game_team|
        if game_team.team_id == team_id
          fewest_goals = game_team.goals if game_team.goals < fewest_goals
        end
      end
    end
    fewest_goals

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
