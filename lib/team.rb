require 'CSV'

class Team 
  attr_reader :id, :name

  def initialize(team_data)
    @id = team_data[:id].to_i
    @name = team_data[:name].to_s
  end

  def self.create_from_csv(file_path)
    teams = []
    CSV.foreach(file_path, headers: true, converters: :all) do |row|
      team_data = {
        id: row["team_id"],
        name: row["teamName"]
      }
    teams << Team.new(team_data)  
    end
    teams
  end

  def self.find_team_name_by_id(team_id)
    @id 
  end
end