class GameTeamData

  def self.create_objects
    table = CSV.parse(File.read('./data/dummy_file_game_teams.csv'), headers: true, converters: :numeric)
    line_index = 0
    all_game_teams = []
    table.size.times do
      game_team_data = GameTeamData.new
      game_team_data.create_attributes(table, line_index)
      all_game_teams << game_team_data
      line_index += 1
    end
    all_game_teams
  end
end
