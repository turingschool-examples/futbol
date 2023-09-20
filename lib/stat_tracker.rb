# require 'csv'
require './spec/spec_helper'

class StatTracker 

  def initialize(locations)
    @@game = game_data_parser(locations[:games])
    @@team_data = team_data_parser(locations[:teams])
    @@game_teams = game_teams_data_parser(locations[:game_teams])
  end
  
  def game
    @@game
  end

  def team_data
    @@team_data
  end

  def game_teams
    @@game_teams
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def team_data_parser(file_location)
    contents = CSV.open file_location, headers: true, header_converters: :symbol
    contents.readlines
  end

  def game_data_parser(file_location)
    contents = CSV.open file_location, headers: true, header_converters: :symbol
    contents.readlines
  end

  def game_teams_data_parser(file_location)
    contents = CSV.open file_location, headers: true, header_converters: :symbol
    contents.readlines
  end

  def method(testing = false)
    testing ? data = game.take(20) : data = game
  end

end