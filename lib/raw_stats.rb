require 'csv'
require './lib/games'
require './lib/teams'
require './lib/game_teams'

class RawStats
  attr_reader :games, :teams, :game_teams
  
  def initialize(data)
    @games = load_data(data[:games], Game)
    @teams = load_data(data[:teams], Team)
    @game_teams = load_data(data[:game_teams], GameTeam)
  end
  
  def load_data(file, class_type)
    CSV.read(file, headers: true, header_converters: :symbol).map { |row| class_type.new(row) }
  end
end

  # def initialize(locations)
  #   @games = []
  #   @teams = []
  #   @game_teams = []
  #   parse_games(locations[:games])
  #   parse_teams(locations[:teams])
  #   parse_game_teams(locations[:game_teams])
  # end

  # def parse_games(data) = CSV.foreach(data, headers:true, header_converters: :symbol) do |line|
  #   @games << Game.new(line)

  # end

  # def parse_teams(data) = CSV.foreach(data, headers:true, header_converters: :symbol) do |line|
  #   @teams <<
  # end

  # def parse_game_teams(data) = CSV.foreach(data, headers:true, header_converters: :symbol) do |line|

  # end