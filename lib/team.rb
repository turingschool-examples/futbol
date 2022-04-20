#Team Stats

class Team

  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link
  def initialize(team_id, franchise_id, team_name, abbreviation, stadium, link)
    @team_id = team_id
    @franchise_id = franchise_id
    @team_name = team_name
    @abbreviation = abbreviation
    @stadium = stadium
    @link = link
  end

  def self.fill_team_array(data)
    team_data = []
    data.each do |row|
      team_id = row[:team_id]
      franchise_id = row[:franchiseid]
      team_name = row[:teamname]
      abbreviation = row[:abbreviation]
      stadium = row[:stadium]
      link = row[:link]
      team_data << Team.new(team_id, franchise_id, team_name,
         abbreviation, stadium, link)
      end
      team_data
  end

  def team_info(team_id)
    team_hash = {}
    @teams.each do |team|
        if team.team_id == team_id
            team_hash = {
            "team_id" => team.team_id,
            "franchise_id" => team.franchise_id,
            "team_name" => team.team_name,
            "abbreviation" => team.abbreviation,
            "link" => team.link
            }
        end
    end
    team_hash 
end
end
