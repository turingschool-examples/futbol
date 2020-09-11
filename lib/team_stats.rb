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

end
