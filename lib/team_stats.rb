require_relative "stats"
require './lib/calculable'

class TeamStats < Stats
include Calculable

  def initialize(file_path)
    Stats.from_csv(file_path)
  end

  def self.team_info(team_id)
  # finds a specific team via their id
   team = team_by_id(team_id)
   # returns an array of the team object's instance variables, then iterates
   # over that array, deletes the '@' from the front of the instance variable
   # and assigns that as a key, then sets the value equal to the key by again
   # removing the '@' and then passing that as a method call then returning it
   # all as a hash
    team_data = team.instance_variables.map { |key,value| ["#{key}".delete("@"), value = team.send("#{key}".delete("@").to_sym)]}.to_h
    # searches the hash for a key, value pair whose key is "stadium" then deletes it.
    team_data.delete_if {|k,v| k == "stadium"}
 end

 def best_season(team_id)
   team_seasons = @@games.find_all {|game| game.home_team_id  == team_id || game.away_team_id == team_id }
   seasons = team_seasons.group_by {|game| game.season}
   seasons.each do |season, season_games|
     season_game_ids = season_games.map{|game| game.game_id}
     team_games = @@game_teams.find_all { |game| game.team_id == team_id && season_game_ids.include?(game.game_id)}
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
end
