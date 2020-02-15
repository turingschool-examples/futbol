require 'CSV'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations_params)
    games_file = locations_params[:games]
    teams_file = locations_params[:teams]
    game_teams_file = locations_params[:game_teams]

    games_array = []
    CSV.foreach(games_file, headers: true, header_converters: :symbol) do |row|
      games_array << row
    end

    teams_array = []
    CSV.foreach(teams_file, headers: true, header_converters: :symbol) do |row|
      teams_array << row
    end

    game_teams_array = []
    CSV.foreach(game_teams_file, headers: true, header_converters: :symbol) do |row|
      game_teams_array << row
    end

    StatTracker.new(games_array, teams_array, game_teams_array)
  end
end
