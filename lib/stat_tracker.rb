require_relative 'team'
require_relative 'game'
require_relative 'game_team'
require_relative 'game_stat'
require_relative 'league_stat'
require 'csv'

class StatTracker
  include GameStat
  include LeagueStat
  attr_reader :all_teams, :all_games, :all_game_teams

  def initialize(team_hash, game_array, game_teams_array)
    @all_teams = team_hash
    @all_games = game_array
    @all_game_teams = game_teams_array
  end

  def self.from_csv(file_paths)
    all_teams = Hash.new
    all_games = Array.new
    all_game_teams = Array.new
    self.generate_hash(file_paths[:teams], Team, all_teams)
    self.generate_data(file_paths[:games], Game, all_games)
    self.generate_data(file_paths[:game_teams], GameTeam, all_game_teams)
    self.new(all_teams, all_games, all_game_teams)
  end


  def self.generate_data(location, obj_type, array)
    CSV.foreach(location, headers: true) do |row|
      array << obj_type.new(row)
    end
  end

  def self.generate_hash(location, obj_type, hash)
    CSV.foreach(location, headers: true) do |row|
      obj = obj_type.new(row)
      hash[row[0]] = obj
    end
  end
end
