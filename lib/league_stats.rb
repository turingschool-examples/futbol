class LeagueStatistics
  attr_reader :teams_data, :game_stats
  def initialize(array_teams_data, game_stats)
    @teams_data = array_teams_data
    @game_stats = game_stats
  end

  def count_of_teams
    @teams_data.length
  end

  def group_by_team_id
    @game_stats.game_teams_data.group_by do |team|
      team[:team_id]
    end
  end

  def team_id_and_average_goals
    hash = {}
    group_by_team_id.each do |team, games|
      total_games = games.map do |game|
        game[:game_id]
      end
      total_goals = games.sum do |game|
        game[:goals]
      end
      hash[team] = (total_goals.to_f / total_games.count).round(2)
    end
    hash
  end

  def best_offense
    best_attack = @teams_data.find do |team|
      team[:teamname] if best_offense_stats == team[:team_id]
    end
    best_attack[:teamname]
  end

  def worst_offense
    worst_attack = @teams_data.find do |team|
      team[:teamname] if worst_offense_stats == team[:team_id]
    end
    worst_attack[:teamname]
  end

  def best_offense_stats
    stats = team_id_and_average_goals.sort_by do |key, value|
      value
    end
    stats[-1][0]
  end

  def worst_offense_stats
    stats = team_id_and_average_goals.sort_by do |key, value|
      value
    end
    stats[0][0]
  end

  def team_id_and_average_away_goals
    away_team_goals = {}
    group_by_team_id.each do |team, games|
      away_games = games.find_all { |game| game[:hoa] == 'away' }
      away_goals = away_games.sum { |game| game[:goals] }
      away_team_goals[team] = (away_goals.to_f / away_games.count).round(3)
    end
    away_team_goals
  end

  def team_highest_away_goals
    away_goals = team_id_and_average_away_goals.sort_by do |team, goals|
      goals
    end
    away_goals[-1][0]
  end

  def highest_scoring_visitor
    visitor = @teams_data.find do |team|
      team[:teamname] if team_highest_away_goals == team[:team_id]
    end
    visitor[:teamname]
  end

  def team_lowest_away_goals
    away_goals = team_id_and_average_away_goals.sort_by do |team, goals|
      goals
    end
    away_goals[0][0]
  end

  def lowest_scoring_visitor
    visitor = @teams_data.find do |team|
      team[:teamname] if team_lowest_away_goals == team[:team_id]
    end
    visitor[:teamname]
  end
end
