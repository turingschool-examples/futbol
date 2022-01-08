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

  # def average_goals(argument_1)
  #   result_2 = {}
  #   argument_1.each do |key, value|
  #     result_2[key] = value.sum / value.size.to_f
  #   end
  # end


  #
  # def away_goals
  #   @game_teams_file.find_all do |row|
  #     row[:hoa] == "away"
  #   end
  # end

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
    #we need team id. Iterate over teams. Access row by team_id. Return teamname
    @teams_file.find_all do |row|
      return row[:teamname] if y[0] == row[:team_id]
    end
  end


  def worst_offense
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
    y = result_2.min_by {|key, value| value}

    @teams_file.find_all do |row|
      return row[:teamname] if y[0] == row[:team_id]
    end
  end

  def highest_scoring_visitor
  away_team_hash = {}
  @games_file.each do |row|
    if away_team_hash[row[:away_team_id]].nil?
      away_team_hash[row[:away_team_id]] = [row[:away_goals].to_i]
    else
      away_team_hash[row[:away_team_id]] << row[:away_goals].to_i
    end
  end

    average_goals_hash_away = {}
    away_team_hash.each do |key, value|
      average_goals_hash_away[key] = value.sum / value.size.to_f
    end
    highest_average_goals_away = average_goals_hash_away.max_by {|key, value| value}

    @teams_file.find_all do |row|
    return row[:teamname] if highest_average_goals_away[0] == row[:team_id]
    end
  end
end
