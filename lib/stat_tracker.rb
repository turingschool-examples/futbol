require "CSV"
require "./lib/games"
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


  def total_games
    games = []
    @game_teams.map do |game|
      games << game.result
    end
  end

  def percentage_tie
    game_ties = @game_teams.select do |game|
      game.result == "TIE"
    end
    (game_ties.count / total_games.count.to_f).round(2)
  end

  def season_names
    @season_name = @games.map do |game|
      game.season
    end.uniq
    @season_name
  end

  def season_games(season_id)
    @games.select do |game|
      game.season == season_id
    end.count
  end #this works!!! need to make dynamic

  def count_of_games_by_season
    games_per_season = {}
      @season_name.each do |season|
        season_games(season)
          games_per_season["#{season}"] = season_games(season)
      end
      games_per_season
    end #to make an interpolated symbol -- games_per_season[:"#{season}"

      #for each season_names iterate and count w/ season games
      #make dynamic, for each season_name array element make key,
      #make value from

end
