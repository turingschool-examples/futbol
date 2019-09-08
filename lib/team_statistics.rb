module TeamStatistics

  def team_info(team_id)
    found_team = @teams.fetch(team_id.to_i)
    {
      "team_id" => found_team.team_id.to_s,
      "franchise_id" => found_team.franchise_id.to_s,
      "team_name" => found_team.team_name,
      "abbreviation" => found_team.abbreviation,
      "link" => found_team.link
    }
  end

  def best_season(team_id)
    team_id = team_id.to_i
    filtered_games = []
    games_by_team = @games.each do |game_id, game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        filtered_games.push(game)
      end
    end

    games_by_season = filtered_games.group_by do |game|
      game.season
    end

    season_win_avg = Hash.new(0)
    games_by_season.each do |season, games|
      home_wins = games.find_all do |game|
        game.home_team_id == team_id && game.home_goals > game.away_goals
      end

      away_wins = games.find_all do |game|
        game.away_team_id == team_id && game.home_goals < game.away_goals
      end
      season_win_avg[season] = ((home_wins.length.to_f + away_wins.length) / games.length).round(2)
    end
    season_win_avg.key(season_win_avg.values.max_by { |value| value})
  end

  def worst_season(team_id)
    team_id = team_id.to_i
    filtered_games = []
    games_by_team = @games.each do |game_id, game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        filtered_games.push(game)
      end
    end

    games_by_season = filtered_games.group_by do |game|
      game.season
    end

    season_win_avg = Hash.new(0)
    games_by_season.each do |season, games|
      home_wins = games.find_all do |game|
        game.home_team_id == team_id && game.home_goals > game.away_goals
      end

      away_wins = games.find_all do |game|
        game.away_team_id == team_id && game.home_goals < game.away_goals
      end
      season_win_avg[season] = ((home_wins.length.to_f + away_wins.length) / games.length).round(2)
    end
    season_win_avg.key(season_win_avg.values.min_by { |value| value})
  end

  def average_win_percentage(team_id)
    team_id = team_id.to_i

    filtered_games = []
    @games.each do |game_id, game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        filtered_games.push(game)
      end
    end

    wins = filtered_games.find_all do |game|
      (game.away_team_id == team_id && game.home_goals < game.away_goals) ||
      (game.home_team_id == team_id && game.home_goals > game.away_goals)
    end

    (wins.length.to_f / filtered_games.length).round(2)
  end

  def most_goals_scored(team_id)
    team_id = team_id.to_i

    filtered_games = game_teams.find_all do |game_team|
      game_team.team_id == team_id
    end

    filtered_games.max_by do |game|
      game.goals
    end.goals
  end
end
