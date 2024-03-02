require 'CSV'

class Team
  @@teams = []
  attr_reader :id, :name

  def initialize(team_data)
    @id = team_data[:id].to_i
    @name = team_data[:name]
  end

  def self.create_from_csv(file_path)
    CSV.foreach(file_path, headers: true, converters: :all) do |row|
      team_data = {
        id: row["team_id"],
        name: row["teamName"]
      }
    @@teams << Team.new(team_data)
    end
    @@teams
  end

  def self.all
    @@teams
  end

  def self.count_of_teams
    @@teams.count
  end

end
