class TeamData



  def self.create_objects
    table = CSV.parse(File.read('./data/dummy_file_teams.csv'), headers: true, converters: :numeric)
    line_index = 0
    all_teams = []
    table.size.times do
      team_data = TeamData.new
      team_data.create_attributes(table, line_index)
      all_teams << team_data
      line_index += 1
    end
    all_teams
  end

end
