require_relative './game'
require_relative './team'
require_relative './game_team'

class Statistics
    attr_reader :game_collection, :game_teams_collection, :teams_collection
  def initialize(data_files)
    @games = data_files[:games]
    @teams = data_files[:teams]
    @game_teams = data_files[:game_teams]

    @game_collection = create_games
    @game_teams_collection = create_game_teams
    @teams_collection = create_teams

    @games_by_season = Hash.new { |h, k| h[k] = [] }
  end

  def create_games
    csv_games = CSV.read(@games, headers: true, header_converters: :symbol)
    csv_games.map { |row| Game.new(row) }
  end

  def create_game_teams
    csv_game_teams = CSV.read(@game_teams, headers: true, header_converters: :symbol)
    csv_game_teams.map { |row| GameTeam.new(row) }
  end

  def create_teams
    csv_teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    csv_teams.map { |row| Team.new(row) }
  end
end
