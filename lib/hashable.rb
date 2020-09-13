module Hashable
  #game_teams_manager
  def coach_wins(season)
    wins = {}
    group_by_coach(season).map do |coach, games|
      total_wins = 0
      total_games = 0
      games.each do |game|
        total_wins += 1 if game.result == 'WIN'
        total_games += 1
      end
      wins[coach] = (total_wins.to_f / total_games).round(3)
    end
    wins
  end

  def goals_to_shots_ratio_per_season(season)
    total_goals = {}
    find_by_team_id(season).each do |team_id, rows|
      sum_goals = rows.sum {|row| row.goals}
      sum_shots = rows.sum {|row| row.shots}
      total_goals[team_id] = (sum_goals.to_f / sum_shots).round(3)
    end
    total_goals
  end

  def total_tackles(season)
    total_tackles = {}
    find_by_team_id(season).each do |team_id, rows|
      sum_tackles = rows.sum {|row| row.tackles}
      total_tackles[team_id] = sum_tackles
    end
    total_tackles
  end

  #team_manager
  def team_id_and_average_goals
    average_goals_by_team = {}
    group_by_team_id.each do |team, games|
      total_games = games.map { |game| game.game_id }
      total_goals = games.sum { |game| game.goals }
      average_goals_by_team[team] = (total_goals.to_f / total_games.count).round(3)
    end
    average_goals_by_team
  end

  def team_id_and_average_away_goals
    away_team_goals = {}
    group_by_team_id.each do |team, games|
      away_games = games.find_all { |game| game.hoa == 'away' }
      away_goals = away_games.sum { |game| game.goals }
      away_team_goals[team] = (away_goals.to_f / away_games.count).round(3)
    end
    away_team_goals
  end

  def team_id_and_average_home_goals
    home_team_goals = {}
    group_by_team_id.each do |team, games|
      home_games = games.find_all { |game| game.hoa == 'home' }
      home_goals = home_games.sum { |game| game.goals }
      home_team_goals[team] = (home_goals.to_f / home_games.count).round(3)
    end
    home_team_goals
  end

  def percent_wins_by_season(team_id)
    wins = {}
    group_by_season(team_id).each do |season, games|
      total_wins = 0
      total_games = 0
      games.each do |game|
        total_wins += 1 if game.result == "WIN"
        total_games += 1
      end
      wins[season] = (total_wins.to_f / total_games).round(3)
    end
    wins
  end

  def hash_by_opponent_id(team_id)
    opponent_ids = {}
    find_opponent_id(team_id).each do |game|
      opponent_ids[game] = find_all_game_ids_by_team(team_id)
    end
    opponent_ids
  end

  def sort_games_against_rival(team_id)
    sorted_games = {}
    hash_by_opponent_id(team_id).each do |rival, games|
      rival_games = games.find_all do |game|
        rival == game.away_team_id || rival == game.home_team_id
      end
      sorted_games[rival] = rival_games
    end
    sorted_games
  end

  def find_count_of_games_against_rival(team_id)
    count = {}
    sort_games_against_rival(team_id).each do |rival_id, rival_games|
      game_count = rival_games.count
      count[rival_id] = game_count
    end
    count
  end

  def find_percent_of_winning_games_against_rival(team_id)
    percent_wins = {}
    sort_games_against_rival(team_id).each do |rival_id, rival_games|
      given_team_win_count = 0
      total_games = 0
      rival_games.each do |game|
        if rival_id == game.away_team_id
          total_games += 1
          if game.away_goals < game.home_goals
            given_team_win_count += 1
          end
        else
          total_games += 1
          if game.home_goals < game.away_goals
            given_team_win_count += 1
          end
        end
      end
      percent_wins[rival_id] = (given_team_win_count.to_f / total_games).round(3)
    end
    percent_wins
  end
end
