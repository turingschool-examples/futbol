require_relative './game_team'
require 'CSV'

class DataLibrary
  attr_reader :game_teams, :games, :teams

  def initialize(locations)
    @games = []
    @game_teams = []
    @teams = []
    create_games(locations[:games])
    create_game_teams(locations[:game_teams])
    create_teams(locations[:teams])
  end

  def create_teams(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @teams << row.to_h
    end
  end

  def create_games(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @games << row.to_h
    end
  end

  def create_game_teams(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @game_teams << row.to_h
    end
  end
end
