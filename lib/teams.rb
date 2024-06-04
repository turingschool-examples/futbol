require 'csv'

class Teams
  attr_reader :team_id, 
              :franchise_id, 
              :team_name, 
              :abbreviation, 
              :stadium, 
              :link

  def initialize(team_id, franchise_id, team_name, abbreviation, stadium, link)
    @team_id = team_id
    @franchise_id = franchise_id
    @team_name = team_name
    @abbreviation = abbreviation
    @stadium = stadium
    @link = link
  end

  def self.create_teams_data_objects(path)
    team_objects = []
    CSV.foreach(path, headers: true) do |row|
      team_objects << Teams.new(row["team_id"].to_i, row["franchiseId"].to_i, row["teamName"], row["abbreviation"], row["Stadium"], row["link"])
    end
    team_objects
  end

end
