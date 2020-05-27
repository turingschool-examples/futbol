require_relative './game'
require_relative './team'
require_relative './game_teams'
require 'pry'
require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(info)
    @games = info[:games]
    @teams = info[:teams]
    @game_teams = info[:game_teams]
  end

  def self.from_csv(info)
    StatTracker.new(info)
  end

  # Game Statistic methods


  # League Statistic methods


  # Season Statistic methods


  # Team Statistic methods
  csv = CSV.read('./data/teams.csv', headers: true, header_converters: :symbol)
  teams_collection = csv.map do |row|
    binding.pry
    Team.new(row)
  end
  puts csv


end
