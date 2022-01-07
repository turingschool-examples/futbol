require 'pry'
require 'CSV'
require './lib/games_collection'
require './lib/teams_collection'
require './lib/games_teams_collection'

class StatTracker
  attr_reader :locations

  def initialize(locations)
    @locations = locations

    @games_file = GamesCollection.new(@locations[:games])
    @teams_file = TeamsCollection.new(@locations[:teams])
    @game_teams_file = GamesTeamsCollection.new(@locations[:game_teams])
    @read_games = @games_file.read_file
    @read_teams = @teams_file.read_file
    @read_game_teams = @game_teams_file.read_file

  end

  def self.from_csv(files)
    StatTracker.new(files)
  end

  def count_of_teams
    @read_teams.size
  end

  def best_offense
    result = {}
    @read_game_teams.each do |row|
      if result[row.team_id].nil?
        result[row.team_id] = [row.goals.to_i]
      else
        result[row.team_id] << row.goals.to_i
      end
    end

    result_2 = {}
    result.each do |key, value|
      result_2[key] = value.sum / value.size.to_f
    end
    y = result_2.max_by {|key, value| value}

    @read_teams.find_all do |row|
      return row.teamname if y[0] == row.team_id
    end
  end
end
