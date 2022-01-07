require 'csv'
require 'pry'

class LeagueStatistics
  attr_reader :files

  def initialize(files)
    @files = files
    @teams_file = CSV.read files[:teams], headers: true, header_converters: :symbol
    @games_file = CSV.read files[:games], headers: true, header_converters: :symbol
    @game_teams_file = CSV.read files[:game_teams], headers: true, header_converters: :symbol
  end

  def count_of_teams
    @teams_file.length
  end

  def goals_by_game
    @games_file.map do |row|
      row[:home_goals].to_i + row[:away_goals].to_i
    end
  end

  def games_by_season
    result ={}
    @games_file.each do |row|
      result[row[:season]] = []
    end
      @games_file.each do |row|
      result[row[:season]] << row[:game_id]
    end
    result
  end

  def count_of_games

  end

  def games_by_teams
    result ={}
    @games_file.each do |row|
      result[row[:team_id]] = []
    end
      @games_file.each do |row|
      result[row[:team_id]] << row[:game_id]
    end
    result
  end

  def all_goals
    total = []
    @games_file.each do |row|
      total << row[:away_goals].to_i
      total << row[:home_goals].to_i
    end
    total
  end

  def average_goals_game
    total_goals = all_goals
    (total_goals.sum.to_f/(total_goals.size/2)).round(2)
  end

  def max_average_goals_team
     average_goals_team.max_by do |key, value|
    end
  end

  def best_offense
    hash_result = {}
    @game_teams_file.each do |row|
      if hash_result[row[:team_id]].nil?
        hash_result[row[:team_id]] = [row[:goals].to_i]
      else
        hash_result[row[:team_id]]<< row[:goals].to_i
      end
    end

    result_2 = {}
    hash_result.each do |key, value|
      result_2[key] = value.sum / value.size.to_f
    end
    y = result_2.max_by {|key, value| value}
    @teams_file.find_all do |row|
      return row[:teamname] if y[0] == row[:team_id]
    end
  end
  end
  #we need team id. Iterate over teams. Access row by team_id. Return teamname
