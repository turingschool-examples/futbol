
class Teams
  attr_reader :team_name,
              :team_id

  def initialize(team_name, team_id)
    @team_name = team_name
    @team_id = team_id
  end

  def self.create_teams(data_path)
    game_instance_array = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      team_name =row[:teamname]
      team_id = row[:team_id]
      game_instance = Teams.new(team_name, team_id)
      game_instance_array << game_instance
    end
    game_instance_array
  end
end
