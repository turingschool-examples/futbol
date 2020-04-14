require_relative "stats"
class TeamStats < Stats

 def team_info(team_id)
   team = team_by_id(team_id)
    team_data = team.instance_variables.map { |key,value| ["#{key}".delete("@"), value = team.send("#{key}".delete("@").to_sym)]}.to_h
    team_data.delete_if {|k,v| k == "stadium"}
 end

 def best_season(team_id)
   team_seasons = @games.find_all {|game| game.home_team_id  == team_id || game.away_team_id == team_id }
   seasons = team_seasons.group_by {|game| game.season}
   seasons.each do |season, season_games|
     season_game_ids = season_games.map{|game| game.game_id}
     team_games = @game_teams.find_all { |game| game.team_id == team_id && season_game_ids.include?(game.game_id)}
     seasons[season] = calculate_win_percentage(team_games)
   end
   seasons.max_by { |season, win_pct|
     win_pct }[0]
 end

 def worst_season(team_id)
   team_seasons = @games.find_all {|game| game.home_team_id  == team_id || game.away_team_id == team_id }
   seasons = team_seasons.group_by {|game| game.season}
   seasons.each do |season, season_games|
     season_game_ids = season_games.map{|game| game.game_id}
     team_games = @game_teams.find_all { |game| game.team_id == team_id && season_game_ids.include?(game.game_id)}
     seasons[season] = calculate_win_percentage(team_games)
   end
   seasons.min_by { |season, win_pct|
     win_pct }[0]
 end

 def average_win_percentage(team_id)
   team_games = all_games_by_team(team_id)
   calculate_win_percentage(team_games).round(2)
 end

 def most_goals_scored(team_id)
   all_games_by_team(team_id).max_by{|game| game.goals}.goals
 end

 def fewest_goals_scored(team_id)
   all_games_by_team(team_id).min_by{|game| game.goals}.goals
 end

 def favorite_opponent(team_id)
   team_games = all_games_by_team(team_id)
   team_games.map! {|game| game.game_id}
   opp_team_games = @game_teams.find_all {|game| team_games.include?(game.game_id) && game.team_id != team_id}
   opp_teams = opp_team_games.group_by {|game| game.team_id}
   win_pct_against = opp_teams.transform_values{|game| 1 - calculate_win_percentage(game)}
   @teams.find {|team| team.team_id == win_pct_against.max_by {|team, win_pct| win_pct}[0]}.team_name
 end

 def rival(team_id)
   team_games = all_games_by_team(team_id)
   team_games.map! {|game| game.game_id}
   opp_team_games = @game_teams.find_all {|game| team_games.include?(game.game_id) && game.team_id != team_id}
   opp_teams = opp_team_games.group_by {|game| game.team_id}
   win_pct_against = opp_teams.transform_values{|game| 1 - calculate_win_percentage(game)}
   @teams.find {|team| team.team_id == win_pct_against.min_by {|team, win_pct| win_pct}[0]}.team_name
 end
end
