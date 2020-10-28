class TeamStatistics
  def team_info(teams, team_id)
    team_data = teams[team_id]
    new_hash = {
      "franchise_id" => team_data.franchiseId.to_s,
      "team_name" => team_data.teamName,
      "abbreviation" => team_data.abbreviation,
      "link" => team_data.link,
      "team_id" => team_id
    }
  end

  def worst_season(games, team_id)
    season_wins_and_losses = add_wins_and_losses(games, team_id)
    highest_win_to_loss = season_wins_and_losses.min_by do |season, win_and_loss_hash|
      win_and_loss_hash[:wins].to_f / win_and_loss_hash[:total]
    end
    highest_win_to_loss[0].to_s
  end

  def add_wins_and_losses(games, team_id)
    win_percent_by_season = {}
    games.each do |game_id, game|
      win_percent_by_season[game.season] ||= {wins: 0, total: 0}
      home_team_won = game.home_goals > game.away_goals
      team_is_home = game.home_team_id == team_id.to_i
      is_draw = game.home_goals == game.away_goals
      team_is_playing = team_is_home || game.away_team_id == team_id.to_i
      if team_is_playing
        win_percent_by_season[game.season][:total] += 1
        if (home_team_won == team_is_home) && !is_draw
          win_percent_by_season[game.season][:wins] += 1
        end
      end
     end
     win_percent_by_season
  end

  def best_season(games, team_id)
    season_wins_and_losses = add_wins_and_losses(games, team_id)
    highest_win_to_loss = season_wins_and_losses.max_by do |season, win_and_loss_hash|
      win_and_loss_hash[:wins].to_f / win_and_loss_hash[:total]
    end
    highest_win_to_loss[0].to_s
  end


  def average_win_percentage(games, team_id)
    total_games = 0
    total_wins = 0
    games.each do |game_id, game|
      home_team_won = game.home_goals > game.away_goals
      is_draw = game.home_goals == game.away_goals
      team_is_home = game.home_team_id == team_id.to_i
      team_is_playing = team_is_home || game.away_team_id == team_id.to_i
      if team_is_playing
        total_games += 1
        if (home_team_won == team_is_home) && !is_draw
          total_wins += 1
        end
      end
     end
     (total_wins / total_games.to_f).floor(2)
  end

  def most_goals_scored(games, team_id)
    games_by_goals(games,team_id).max
  end

  def fewest_goals_scored(games, team_id)
    games_by_goals(games,team_id).min
  end

  def games_by_goals(games, team_id)
    goals = []
    games.each do |game_id, game|
      team_is_home = game.home_team_id == team_id.to_i
      team_is_playing = team_is_home || game.away_team_id == team_id.to_i
      if team_is_playing && team_is_home
        goals << game.home_goals
      elsif team_is_playing
        goals << game.away_goals
      end
    end
    goals
  end


  def favorite_opponent(games, teams, team_id)
    overall_wins = team_by_win_percentage(games, team_id).max_by do |team_id, wins_hash|
      wins_hash[:wins] / wins_hash[:total].to_f
    end
    team_name_from_id(teams,overall_wins[0].to_s)
  end

  def team_by_win_percentage(games, team_id)
    percent_hash = {}
    games.each do |game_id, game|
      int_id = team_id.to_i
      home_team_won = game.home_goals > game.away_goals
      team_is_home = game.home_team_id == int_id
      is_draw = game.home_goals == game.away_goals
      if team_is_home
        opponent_id = game.away_team_id
      else
        opponent_id = game.home_team_id
      end
      team_is_playing = team_is_home || game.away_team_id == int_id
      if team_is_playing
        percent_hash[opponent_id] ||= {wins: 0, total: 0}
        percent_hash[opponent_id][:total] += 1
        if (home_team_won == team_is_home) && !is_draw
          percent_hash[opponent_id][:wins] += 1
        end
      end
     end
     percent_hash
  end

  def team_name_from_id(teams,id)
    teams.find do |team_id, team|
      team_id == id
    end[1].teamName
  end


  def rival(games, teams, team_id)
    overall_wins = team_by_win_percentage(games, team_id).min_by do |team_id, wins_hash|
      wins_hash[:wins] / wins_hash[:total].to_f
    end
    team_name_from_id(teams,overall_wins[0].to_s)
  end

end
