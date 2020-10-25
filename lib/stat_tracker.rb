require 'csv'
require 'pry'
require './lib/game_teams'

class StatTracker
  attr_reader :game_path, :team_path, :game_teams_path
  def initialize(locations)
    @game_path = locations[:games]
    @team_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
    # games = CSV.read(locations[:games], headers: true)
    # teams = CSV.read(locations[:teams], headers: true)
    # game_teams = CSV.read(locations[:game_teams], headers: true)

    
  end

  def highest_total_score
    rows = CSV.read(@game_teams_path, headers: true, header_converters: :symbol)
    result = []
    team_id_match = rows.select do |row|
    row[:team_id] == "1"
    end

    team_id_match.each do |object|
      result << GameTeams.new(object)
    end

    team_1_total_goals = result.inject(0) do |sum, obj|
      sum += obj.goals
    end
  
    team_1_total_goals
    #compile total goals by team_id, return highest total goals.
  end
end

