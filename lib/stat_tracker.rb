require "csv"

class StatTracker
  attr_reader :teams, :games, :game_teams

  def initialize(team_path, game_path, game_teams_path)
    @teams = read_teams_from_csv(team_path)
    @games = read_games_from_csv(game_path)
    @game_teams = read_game_teams_from_csv(game_teams_path)
  end

  def self.from_csv(locations)
    self.new(locations[:teams], locations[:games], locations[:game_teams])
  end

  CSV::Converters[:symbol] = ->(value) {value.to_sym rescue value}

  def read_teams_from_csv(path)
    CSV.parse(File.read(path), {headers: true, header_converters: :symbol})
  end

  def read_games_from_csv(path)
    CSV.parse(File.read(path), {headers: true, header_converters: :symbol})
  end

end
