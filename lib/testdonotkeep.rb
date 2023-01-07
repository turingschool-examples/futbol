def find_corresponding_games_by_gameteam(relevant_game_teams)
   games.find_all do |game|
     relevant_game_teams.each {|game_team| game_team[:game_id] == game[:game_id]} 
     end
 end