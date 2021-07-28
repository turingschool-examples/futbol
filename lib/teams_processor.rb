require 'csv'

module TeamsProcessor
  def parse_teams_file(file_path)
    teams = []

    CSV.foreach(file_path, headers: true) do |row|
      teams << {
        "team_id" => row["team_id"],
        "franchise_id" => row["franchiseId"],
        "team_name" => row["teamName"],
        "abbreviation" => row["abbreviation"],
        "link" => row["link"]
      }
    end
    teams
  end

  def team_info(team_id)
    @teams.find do |team|
      team["team_id"] == team_id
    end
  end

  def count_of_teams
    @teams.count
  end

  def best_offense
    team_id = get_offense_averages.max_by do |team, data|
      data
    end.first

    team_info(team_id)["team_name"]
  end

  def worst_offense
    team_id = get_offense_averages.min_by do |team, data|
      data
    end.first

    team_info(team_id)["team_name"]
  end

  def get_offense_averages
     get_goals_per_team.map do |team, data|
      [team, data[:goals].fdiv(data[:total])]
    end.to_h
  end

  def get_goals_per_team
    team_goals = {}
    @games.each do |game|
      team_goals[game[:home_team_id]] ||= {goals: 0, total: 0}
      team_goals[game[:away_team_id]] ||= {goals: 0, total: 0}

      team_goals[game[:home_team_id]][:goals] += game[:home_goals].to_i
      team_goals[game[:home_team_id]][:total] += 1

      team_goals[game[:away_team_id]][:goals] += game[:away_goals].to_i
      team_goals[game[:away_team_id]][:total] += 1
    end
    team_goals
  end
end
