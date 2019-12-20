require_relative "game_teams"
require_relative 'csv_loadable'

class GameTeamsCollection
  include CsvLoadable

  attr_reader :game_teams_array

  def initialize(file_path)
    @game_teams_array = create_game_teams_array(file_path)
  end

  def create_game_teams_array(file_path)
    # csv = CSV.read(file_path, headers: true, header_converters: :symbol)
    #
    # csv.map { |row| GameTeams.new(row) }
    load_from_csv(file_path, GameTeams)
  end

  def game_teams_lists_by_id
    @game_teams_array.reduce({}) do |hash, game_teams|
      hash[game_teams.team_id] << game_teams if hash[game_teams.team_id]
      hash[game_teams.team_id] = [game_teams] if hash[game_teams.team_id].nil?
      hash
    end
  end

  def home_games_only
    home_only = {}
    game_teams_lists_by_id.each do |team_id, games|
      home_only[team_id] = games.find_all do |game|
        game.hoa == "home"
      end
    end
    home_only
  end

  def away_games_only
    away_only = {}
    game_teams_lists_by_id.each do |team_id, games|
      away_only[team_id] = games.find_all do |game|
        game.hoa == "away"
      end
    end
    away_only
  end

  def home_games_only_average
    home_only_average = {}
    home_games_only.each do |game_id, games|
    home_only_average[game_id] = (games.sum { |game| game.goals.to_i} / games.length.to_f).round(2)
    end
    home_only_average
  end

  def away_games_only_average
    away_only_average = {}
    away_games_only.each do |game_id, games|
    away_only_average[game_id] = (games.sum { |game| game.goals.to_i} / games.length.to_f).round(2)
    end
    away_only_average
  end
end
