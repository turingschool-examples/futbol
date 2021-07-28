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
    team_id = get_goals_per_team.each.max_by do |team, goals|
      goals
    end.first

    team_info(team_id)["team_name"]
  end

  def worst_offense
    team_id = get_goals_per_team.each.min_by do |team, goals|
      goals
    end.first

    team_info(team_id)["team_name"]
  end

  def get_goals_per_team
    team_goals = Hash.new(0)

    @game_teams.each do |game|
      team_goals[game[:team_id]] += game[:goals].to_i
    end
    team_goals
  end
end
