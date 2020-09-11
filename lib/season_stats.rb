class SeasonStatistics
  attr_reader :game_data,
              :game_teams_data,
              :teams_data

  def initialize(array_game_data, array_game_teams_data, array_teams_data)
    @game_data = array_game_data
    @game_teams_data = array_game_teams_data
    @teams_data = array_teams_data
  end

  def hash_of_seasons(season) #refactor: move to module
    @game_teams_data.find_all do |game_team|
      game_team[:game_id].to_s.split('')[0..3].join.to_i == season.split('')[0..3].join.to_i
    end
  end

  def group_by_coach(season)
    hash_of_seasons(season).group_by {|game| game[:head_coach]}
  end

  def coach_wins(season)
    hash = {}
    group_by_coach(season).map do |coach, games|
      total_wins = 0
      total_games = 0
      games.each do |game|
        total_wins += 1 if game[:result] == 'WIN'
        total_games += 1
      end
      hash[coach] = (total_wins.to_f / total_games).round(3)
    end
    hash
  end

  def winningest_coach(season)
   best_coach =  coach_wins(season).max_by {|coach, win| win}
    best_coach[0]
  end

  def worst_coach(season)
   worst_coach =  coach_wins(season).min_by {|coach, win| win}
    worst_coach[0]
  end

  def find_by_team_id(season)
    hash_of_seasons(season).group_by {|team| team[:team_id]}
  end

  def most_accurate_team(season)
    accurate = @teams_data.find do |team|
      team[:teamname] if find_most_accurate_team(season) == team[:team_id]
    end
    accurate[:teamname]
  end

  def find_most_accurate_team(season)
    most_accurate = goals_to_shots_ratio_per_season(season).sort_by {|team_id, goals| goals}
    most_accurate[-1][0]
  end

  def goals_to_shots_ratio_per_season(season)
    total_goals = {}
    find_by_team_id(season).each do |team_id, rows|
      sum_goals = rows.sum {|row| row[:goals]}
      sum_shots = rows.sum {|row| row[:shots]}
      total_goals[team_id] = (sum_goals.to_f / sum_shots).round(3) * 100
    end
    total_goals
  end

  def find_least_accurate_team(season)
    least_accurate = goals_to_shots_ratio_per_season(season).sort_by {|team_id, goals| goals}
    least_accurate[0][0]
  end

  def least_accurate_team(season)
    not_accurate = @teams_data.find do |team|
      team[:teamname] if find_least_accurate_team(season) == team[:team_id]
    end
    not_accurate[:teamname]
  end

  def most_tackles(season)
    most_tackles = @teams_data.find do |team|
      team[:teamname] if find_team_with_most_tackles(season) == team[:team_id]
    end
    most_tackles[:teamname]
  end

  def find_team_with_most_tackles(season)
    team = total_tackles(season).sort_by {|team_id, tackles| tackles}
    team[-1][0]
  end

  def total_tackles(season)
    total_tackles = {}
    find_by_team_id(season).each do |team_id, rows|
      sum_tackles = rows.sum {|row| row[:tackles]}
      total_tackles[team_id] = sum_tackles
    end
    total_tackles
  end
end
