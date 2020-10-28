# require_relative './game_team'
require 'CSV'

class DataLibrary
  attr_reader :game_teams, :games, :teams

  def initialize(locations)
    @games = []
    create_games(locations[:games])
    @game_teams = []
    create_game_teams(locations[:game_teams])
    @teams = []
    create_teams(locations[:teams])
  end

  def create_teams(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @teams << row.to_h
    end
  end

  def create_games(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      game = row.to_h
      game[:total_score] = game[:home_goals].to_i + game[:away_goals].to_i
      @games << game
    end
  end

  def create_game_teams(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @game_teams << row.to_h
    end
  end
end
