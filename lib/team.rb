require 'CSV'

class Team 
    attr_reader :id, :name

    def initialize(id, name)
        @id = id.to_i
        @name = name
    end

    def self.create_from_csv(file_path)
        CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
            team_id = row[:team_id]
            team_name = row[:teamName]
            Team.new(team_id, team_name)
        end
    end

end