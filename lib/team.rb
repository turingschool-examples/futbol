class Team
  extend CsvLoadable

  attr_reader :team_id, :team_name, :franchise_id, :abbreviation, :link

  @@all_teams = []

  def self.all
    @@all_teams
  end

  def self.from_csv(file_path)
    @@all_teams = load_from_csv(file_path, Team)
  end

  def initialize(team_info)
    @team_id = team_info[:team_id].to_i
    @franchise_id = team_info[:franchiseid]
    @team_name = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @link = team_info[:link]
  end

  def self.team_info(teamid)
    team = find_team(teamid)
    teaminfo = {"team_id" => team.team_id, "franchise_id" => team.franchise_id,
                "team_name" => team.team_name, "abbreviation" => team.abbreviation,
                "link" => team.link}
  end

  def self.find_team(teamid)
    @@all_teams.find do |team|
      team.team_id == teamid
    end
  end
end
