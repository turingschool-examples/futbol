class TeamStats
  attr_reader :game_data,
              :game_teams_data,
              :teams_data

  def initialize(data)
    @game_data = data.game_data
    @game_teams_data = data.game_teams_data
    @teams_data = data.teams_data
  end

  def group_teams_data
    @teams_data.group_by do |row|
      row[:team_id]
    end
  end

  def team_info(team_id)
    v = []
    group_teams_data.each do |key, data|
      data.each do |row|
        if team_id == key.to_s
          v << row
        end
      end
    end
    key_transform = v[0].transform_keys {|k| k.to_s}
    value_transform = key_transform.transform_values {|v| v.to_s}
  end

  def all_team_games(team_id)
    @game_teams_data.find_all do |game_team|
      game_team[:team_id] == team_id.to_i
    end
  end

  def group_by_season(team_id)
    all_team_games(team_id).group_by do |game|
      game[:game_id].to_s[0..3]
    end
  end

  def percent_wins_by_season(team_id)
    wins = {}
    group_by_season(team_id).each do |season, games|
      total_wins = 0
      total_games = 0
      games.each do |game|
        total_wins += 1 if game[:result] == "WIN"
        total_games += 1
      end
      wins[season] = (total_wins.to_f / total_games).round(3)
    end
    wins
  end

  def best_season(team_id)
    best = percent_wins_by_season(team_id).max_by do |season, percent_wins|
      percent_wins
    end
    best_year = best[0].to_i
    result = "#{best_year}201#{best_year.digits[0] + 1}"
  end

  def worst_season(team_id)
    worst = percent_wins_by_season(team_id).min_by do |season, percent_wins|
      percent_wins
    end
    worst_year = worst[0].to_i
    result = "#{worst_year}201#{worst_year.digits[0] + 1}"
  end

  def average_win_percentage(team_id)
  (total_wins(team_id).count.to_f / all_team_games(team_id).count).round(2)
  end

  def total_wins(team_id)
    all_team_games(team_id).find_all do |game|
      game[:result] == "WIN"
    end
  end

  def most_goals_scored(team_id)
    most = all_team_games(team_id).max_by do |game|
      game[:goals]
    end
    most[:goals]
  end

  def fewest_goals_scored(team_id)
    fewest = all_team_games(team_id).min_by do |game|
      game[:goals]
    end
    fewest[:goals]
  end
  #
  # def find_team_id(team_id)
  #   @game_teams_data.group_by do |game|
  #     game[:game_id]
  #   end
  # end

  def find_all_game_ids_by_team(team_id)
    @game_data.find_all do |game|
      game[:home_team_id] == team_id.to_i || game[:away_team_id] == team_id.to_i
    end
  end

  def find_opponent_id(team_id)
    find_all_game_ids_by_team(team_id).map do |game|
      if game[:home_team_id] == team_id.to_i
        game[:away_team_id]
      else
        game[:home_team_id]
      end
    end
  end

  def hash_by_opponent_id(team_id)
    hash = {}
    find_opponent_id(team_id).each do |game|
      hash[game] = find_all_game_ids_by_team(team_id)
    end
    hash
  end

  def sort_games_against_rival(team_id)
    hash = {}
    hash_by_opponent_id(team_id).each do |rival, games|
      rival_games = games.find_all do |game|
        rival == game[:away_team_id] || rival == game[:home_team_id]
      end
      hash[rival] = rival_games
    end
    hash
  end

  def find_count_of_games_against_rival(team_id)
    hash = {}
    sort_games_against_rival(team_id).each do |rival_id, rival_games|
      game_count = rival_games.count
      hash[rival_id] = game_count
    end
    hash
  end

  def find_percent_of_winning_games_against_rival(team_id)
    hash = {}
    sort_games_against_rival(team_id).each do |rival_id, rival_games|
      given_team_win_count = 0
      total_games = 0
      rival_games.each do |game|
        if rival_id == game[:away_team_id]
          total_games += 1
          if game[:away_goals] < game[:home_goals]
            given_team_win_count += 1
          end
        else
          total_games += 1
          if game[:home_goals] < game[:away_goals]
            given_team_win_count += 1
          end
        end
      end
      hash[rival_id] = (given_team_win_count.to_f / total_games).round(3) * 100
    end
    hash
  end

  def favorite_opponent_id(team_id)
    fav_opponent = find_percent_of_winning_games_against_rival(team_id).max_by do |rival_id, wins|
      wins
    end
    fav_opponent[0]
  end

  def favorite_opponent(team_id)
    opponent_id = favorite_opponent_id(team_id)
    opponent_name = @teams_data.find do |team|
      team[:teamname] if opponent_id == team[:team_id]
    end
    opponent_name[:teamname]
  end

  def rival_opponent_id(team_id)
    rival_opponent = find_percent_of_winning_games_against_rival(team_id).min_by do |rival_id, wins|
      wins
    end
    rival_opponent[0]
  end
end
