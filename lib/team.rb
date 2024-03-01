require 'CSV'

class Team 
  @@all = []
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
    @@all << Team.new(team_data)  
    end
    teams
  end

  def all
    @@all
  end

  def self.find_team_name_by_id(team_id)
    x = []
    team_id_and_name_hash = {}
    require 'pry'; binding.pry
    x = @@all.each do |team| 
    team_id_and_name_hash[team.id] = team.name
    end
  end
end