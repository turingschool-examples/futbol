require "CSV"
require "./lib/games"
require "./lib/teams"
require "./lib/game_teams"
require "./lib/teams"
# require_relative "./games"
# require_relative "./game_teams"
# require_relative "./teams"

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


    def fewest_tackles(season)
        season_hash = @games.group_by {|games| games.season}
        season_hash.delete_if {|k, v| k.nil?}

        game_ids_by_season = {}
          season_hash.map do |season, games|
            game_ids_by_season[season] = games.map {|game| game.game_id}
          end


        games_by_season = {}
        game_ids_by_season.map do |season, game_ids|
          season_games = @game_teams.map do |game|
            if game_ids.include?(game.game_id)
              game
            end
          end
          games_by_season[season] = season_games
        end

      season_games = games_by_season.map {|season, games| games}.flatten.compact

      new_hash = Hash.new([])
      game_ids_by_season.each do |k, v|
        v.each do |game|
        new_hash[k] += season_games.select {|season_game| season_game.game_id == game}
        end
      end

      team_tackles = Hash.new(0)
        new_hash[season].each do |game|
          team_tackles[game.team_id] += game.tackles
        end
      team_tackles.delete_if {|k, v| k.nil? || k.nil?}

      fewest = team_tackles.min_by {|k, v| v}
      @teams.find {|team| team.team_id == fewest.first}.teamname
    end#tackle method

    def most_tackles(season)
        season_hash = @games.group_by {|games| games.season}
        season_hash.delete_if {|k, v| k.nil?}

        game_ids_by_season = {}
          season_hash.map do |season, games|
            game_ids_by_season[season] = games.map {|game| game.game_id}
          end


        games_by_season = {}
        game_ids_by_season.map do |season, game_ids|
          season_games = @game_teams.map do |game|
            if game_ids.include?(game.game_id)
              game
            end
          end
          games_by_season[season] = season_games
        end

      season_games = games_by_season.map {|season, games| games}.flatten.compact

      new_hash = Hash.new([])
      game_ids_by_season.each do |k, v|
        v.each do |game|
        new_hash[k] += season_games.select {|season_game| season_game.game_id == game}
        end
      end

      team_tackles = Hash.new(0)
        new_hash[season].each do |game|
          team_tackles[game.team_id] += game.tackles
        end
        team_tackles.delete_if {|k, v| k.nil? || k.nil?}

      most = team_tackles.max_by {|k, v| v}
      binding.pry
      @teams.find {|team| team.team_id == most.first}.teamname

      #fewest = team_tackles.min_by {|k, v| v}
      #@teams.find {|team| team.team_id == fewest.first}.teamname
    end#tackle method
end
