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

  end
end
