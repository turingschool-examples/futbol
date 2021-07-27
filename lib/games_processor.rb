require 'csv'

module GamesProcessor
  def parse_games_file(file_path)
    games = []

    CSV.foreach(file_path, headers: true) do |row|
      games << {
        game_id: row["game_id"],
        season: row["season"],
        away_team_id: row["away_team_id"],
        home_team_id: row["home_team_id"],
        away_goals: row["away_goals"],
        home_goals: row["home_goals"]
      }
    end
    games
  end

  def best_season(team_id)
    season_avg = seasons_win_count(team_id)
    season_avg.each.max_by do |season, stats|
      stats[:wins].fdiv(stats[:total])
    end.first
  end

  def worst_season(team_id)
    season_avg = seasons_win_count(team_id)
    season_avg.each.min_by do |season, stats|
      stats[:wins].fdiv(stats[:total])
    end.first
  end

  def seasons_win_count(team_id)
    season_avg = {}

    @games.each do |game|
      season = game[:season]
      if game[:home_team_id] == team_id || game[:away_team_id] == team_id
        season_avg[season] ||= {wins: 0, total: 0}
        if game[:home_team_id] == team_id
          home_win = game[:home_goals] > game[:away_goals]
          season_avg[season][:wins] += 1 if home_win
        else
          away_win = game[:home_goals] < game[:away_goals]
          season_avg[season][:wins] += 1 if away_win
        end
        season_avg[season][:total] += 1
      end
    end
    season_avg
  end

  def average_win_percentage(team_id)
    wins = 0
    games = 0
    seasons_win_count(team_id).each do |season, stats|
      wins += stats[:wins]
      games += stats[:total]
    end
    (wins.fdiv(games)).round(2)
  end

  def opponent_win_count(team_id)
    win_loss = {}
    @games.each do |game|
      if game[:home_team_id] == team_id || game[:away_team_id] == team_id
        teams = [game[:home_team_id], game[:away_team_id]]
        goals = [game[:home_goals], game[:away_goals]]
        team_index = teams.index(team_id)
        opp_index = team_index - 1

        win_loss[teams[opp_index]] ||= {wins: 0, total: 0}
        if goals[team_index] > goals[opp_index]
          win_loss[teams[opp_index]][:wins] += 1
        end
        win_loss[teams[opp_index]][:total] += 1
      end
    end
    win_loss
  end

  def calculate_win_percents(team_id)
    win_loss = opponent_win_count(team_id)
    win_loss.each.map do |team, results|
      avg = results[:wins].fdiv(results[:total])
      [team, avg]
    end.to_h
  end

  def favorite_opponent(team_id)
    win_loss = calculate_win_percents(team_id)
    fav_team = win_loss.each.max_by do |team, result|
      result
    end.first

    team_info(fav_team)["team_name"]
  end

  def rival(team_id)
    win_loss = calculate_win_percents(team_id)
    rival_team = win_loss.each.min_by do |team, result|
      result
    end.first

    team_info(rival_team)["team_name"]
  end
end
