require 'csv'
require_relative 'team'
require_relative 'game'
require_relative "game_team"
require_relative 'game_statable'

class StatTracker
include GameStatable

  attr_reader :games, :teams, :game_teams

  def initialize(files)
    @games = (CSV.foreach files[:games], headers: true, header_converters: :symbol).map do |row|
      Game.new(row)
    end
    @teams = (CSV.foreach files[:teams], headers: true, header_converters: :symbol).map do |row|
      Team.new(row)
    end
    @game_teams = (CSV.foreach files[:game_teams], headers: true, header_converters: :symbol).map do |row|
      GameTeam.new(row)
    end
  end

  def total_home_goals 
    total_goals = @game_teams.each_with_object({}) do |game, hash|
      hash[game.team_id] = hash[game.team_id] || [0, 0]
      hash[game.team_id] = [game.goals + hash[game.team_id][0], hash[game.team_id][1] + 1] if game.hoa == "home"
    end
  end

  def highest_scoring_home_team
    avg_goals = total_home_goals.transform_values do |value|
      (value[0] / value[1].to_f).round(4)
    end
    highest_avg_goals = avg_goals.values.max
    
    highest_team_id = avg_goals.key(highest_avg_goals)

    @teams.each do |team| 
      return team.team_name if team.team_id == highest_team_id
    end
  end

  def lowest_scoring_home_team
    avg_goals = total_home_goals.transform_values do |value|
      (value[0] / value[1].to_f).round(4)
    end
    lowest_avg_goals = avg_goals.values.min

    lowest_team_id = avg_goals.key(lowest_avg_goals)

    @teams.each do |team| 
      return team.team_name if team.team_id == lowest_team_id
    end
  end

  def highest_scoring_visitor 
    #make a hash of of total away games by team id
    away_games_by_team_id = @games.each_with_object(Hash.new(0.0)) do |game, hash|
      hash[game.away_team_id] += 1
    end
    #make a hash of total away goals by team id
    away_goals_by_team_id = @games.each_with_object(Hash.new(0.0)) do |game, hash|
      hash[game.away_team_id] += game.away_goals
    end
    
    #average them together, very similar to the average we did with #average_goals_by_season
    average_away_goals_by_team_id = Hash.new(0.0)
    away_goals_by_team_id.each do |key, value|
      average_away_goals_by_team_id[key] = (value/ away_games_by_team_id[key]).round(2)
    end
    average_away_goals_by_team_id
    #find the lowest scoring team key/value pair and return only the key because
    #this produces at array
    highest_average_scoring_team_id = average_away_goals_by_team_id.max_by {|k, v| v}.first
    
    #iterate through @teams data and find which team has the id that matched to the
    #previous variable
    highest_scoring_team = @teams.find do |team|
      team.team_name if team.team_id == highest_average_scoring_team_id
    end
    team = highest_scoring_team.team_name
  end

    #I reused all the code from above, but only changes the names of the last variables
    #to say "lowest"
  def lowest_scoring_visitor 
    away_games_by_team_id = @games.each_with_object(Hash.new(0.0)) do |game, hash|
      hash[game.away_team_id] += 1
    end

    away_goals_by_team_id = @games.each_with_object(Hash.new(0.0)) do |game, hash|
      hash[game.away_team_id] += game.away_goals
    end
    
    average_away_goals_by_team_id = Hash.new(0.0)
    away_goals_by_team_id.each do |key, value|
      average_away_goals_by_team_id[key] = (value/ away_games_by_team_id[key]).round(2)
    end
    average_away_goals_by_team_id
    lowest_average_scoring_team_id = average_away_goals_by_team_id.min_by {|k, v| v}.first
    
    lowest_scoring_team = @teams.find do |team|
      team.team_name if team.team_id == lowest_average_scoring_team_id
    end
    team = lowest_scoring_team.team_name
    # require 'pry';binding.pry
  end

  def self.from_csv(files)
    StatTracker.new(files)
  end
end