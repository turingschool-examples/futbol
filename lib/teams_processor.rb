require 'csv'

module TeamsProcessor
  def parse_teams_file(file_path)
    teams = []

    CSV.foreach(file_path, headers: true) do |row|
      teams << {
        team_id: row["team_id"],
        franchise_id: row["franchiseId"],
        team_name: row["teamName"],
        abbrev: row["abbreviation"],
        link: row["link"]
      }
    end
    teams
  end

  def team_info
    @teams 
  end
end
