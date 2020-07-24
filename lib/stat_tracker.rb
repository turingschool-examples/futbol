require "CSV"
require "./lib/games"
require "./lib/teams"
require "./lib/game_teams"
require "./lib/teams"

class StatTracker
  attr_reader :games, :game_teams, :teams

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @games ||= turn_games_csv_data_into_games_objects(locations[:games])
    @teams ||= turn_teams_csv_data_into_teams_objects(locations[:teams])
    @game_teams ||= turn_game_teams_csv_data_into_game_teams_objects(locations[:game_teams])
  end

  def turn_games_csv_data_into_games_objects(games_csv_data)
    games_objects_collection = []
    CSV.foreach(games_csv_data, headers: true, header_converters: :symbol) do |row|
      games_objects_collection << Games.new(row)
    end
    games_objects_collection
  end

  def turn_teams_csv_data_into_teams_objects(teams_csv_data)
    teams_objects_collection = []
    CSV.foreach(teams_csv_data, headers: true, header_converters: :symbol) do |row|
      teams_objects_collection << Teams.new(row)
    end
    teams_objects_collection
  end

  def turn_game_teams_csv_data_into_game_teams_objects(game_teams_csv_data)
    game_teams_objects_collection = []
    CSV.foreach(game_teams_csv_data, headers: true, header_converters: :symbol) do |row|
      game_teams_objects_collection << GameTeams.new(row)
    end
    game_teams_objects_collection
  end



###########################

  def season_hash
    season_hash = @games.group_by {|games| games.season}
          season_hash.delete_if {|k, v| k.nil?}
  end

  def game_ids_by_season
      game_ids_by_season = {}
        season_hash.map do |season, games|
          game_ids_by_season[season] = games.map {|game| game.game_id}
        end
        game_ids_by_season
  end

  def games_by_season
      games_by_season = {}
      game_ids_by_season.map do |season, game_ids|
        season_games = @game_teams.map do |game|
          if game_ids.include?(game.game_id)
            game
          end
        end
        games_by_season[season] = season_games
      end
      games_by_season
  end


  def season_games
    season_games = games_by_season.map {|season, games| games}.flatten.compact
  end


  def best_season(teamID)
    games_by_team = season_games.select {|team| team.team_id == teamID}
    #array of all games from teamID
   team_games_per_season = games_by_team.group_by {|game| game.game_id[0..3]}
    #hash organized with season keys and games per season as value
    win_hash = Hash.new(0)
    team_games_per_season. each do |season, games|
      count = 0
      total = 0
      games.each do |game|
          if game.result == "WIN"
            count += 1
            total += 1
          else
            total += 1
          end
      win_hash[season] = [count, total]
        end
      end


  best = win_hash.max_by do |season, games|
    win_hash[season].first / win_hash[season].last.to_f
end

  math = best[0].to_i
  math += 1
  math.to_s

  answer = best.first + "#{math}"
  end#method


  def worst_season(teamID)
    games_by_team = season_games.select {|team| team.team_id == teamID}
    #array of all games from teamID
    team_games_per_season = games_by_team.group_by {|game| game.game_id[0..3]}
    #hash organized with season keys and games per season as value
    win_hash = Hash.new(0)
    team_games_per_season. each do |season, games|
      count = 0
      total = 0
      games.each do |game|
        if game.result == "WIN"
          count += 1
          total += 1
        else
          total += 1
        end
      win_hash[season] = [count, total]
    end
  end
  worst = win_hash.min_by do |season, games|
    win_hash[season].first / win_hash[season].last.to_f
end

  math = worst[0].to_i
  math += 1
  math.to_s
  worst = worst.first + "#{math}"
  end#method




end #class
