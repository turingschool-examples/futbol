def game_data_shrinker 
  game_fixture = @@game.find_all do |row| 
    ["1", "2", "3", "4"].include?(row[:away_team_id]) && 
    ["1", "2", "3", "4"].include?(row[:home_team_id])
  end
  game_fixture.map do |row|
   row.to_s
  end
end

def game_teams_data_shrinker 
  game_id = game.map do |row|
    row[:game_id]
  end
  game_teams_fixture = @@game_teams.find_all do |row| 
    game_id.include?(row[:game_id])
  end
  game_teams_fixture.map do |row|
   row.to_s
  end
end