require 'csv'

class LeagueStatistics
  attr_reader :locations,
              :teams_data,
              :game_data,
              :game_team_data

  def initialize(locations)
    @locations = locations
    @game_data = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams_data = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_team_data = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end

  def count_of_teams
    team_ids = teams_data.map { |row| row[:team_id].to_i }

    team_ids.size
  end

  def team_name_by_id(team_id)
    team_id = team_id.to_i
    team = @teams_data.find { |row| row[:team_id].to_i == team_id }
    team[:teamname] if team
  end
  
  def best_offense
    goals_per_team = Hash.new { |hash, key| hash[key] = { total_goals: 0, games_played: 0 } }

    @game_team_data.each do |row|
      team_id = row[:team_id].to_i
      goals = row[:goals].to_i
      goals_per_team[team_id][:total_goals] += goals
      goals_per_team[team_id][:games_played] += 1
    end
    
    highest_average_team_id = nil
    highest_average = 0.0

    goals_per_team.each do |team_id, data|
      average_goals = data[:total_goals].to_f / data[:games_played]
      if average_goals > highest_average
        highest_average = average_goals
        highest_average_team_id = team_id
      end
    end
    team_name_by_id(highest_average_team_id)
  end
 
  def worst_offense
    team_ids = @game_team_data[:team_id].uniq
    lowest_scoring_team = team_ids.min_by do |team_id|
      average_goals_for_team(team_id)
    end  

    team = @teams_data.find do |team|
      team[:team_id] == lowest_scoring_team
    end 
    team[:teamname] 
  end 
  
  def average_goals_for_team(team_id)
    games = @game_team_data.find_all do |game_team|
      game_team[:team_id] == team_id  
    end 

    total_goals = games.map do |game|
      game[:goals].to_i 
    end.sum
    average_goals_per_season = total_goals / games.length 
  end    

  def highest_scoring_visitor
    team_ids = @game_team_data[:team_id].uniq
    highest_scoring_visitor = team_ids.max_by do |team_id|
      average_goals_by_visitor(team_id)
    end 
    team = @teams_data.find do |team|
      team[:team_id] == highest_scoring_visitor
    end 
    team[:teamname] 
  end 

  def average_goals_by_visitor(team_id)
    away_games = @game_team_data.find_all do |game_team|
      game_team[:hoa]== "away"
      game_team[:team_id] == team_id
    end
    total_away_goals = away_games.map do |away_game|
      away_game[:goals].to_i 
    end.sum
    average_goals_by_visitor = total_away_goals / away_games.length  
  end  

  def highest_scoring_home_team
    team_ids = @game_team_data[:team_id].uniq
    highest_scoring_hometeam = team_ids.max_by do |team_id|
      average_goals_by_hometeam(team_id)
    end  
    team = @teams_data.find do |team|
      team[:team_id] == highest_scoring_hometeam
    end 
    team[:teamname] 
  end 

  def average_goals_by_hometeam(team_id)
    home_games = @game_team_data.find_all do |game_team|
      game_team[:hoa]== "home"
      game_team[:team_id] == team_id 
    total_home_goals = home_games.map do |home_game|
      home_game[:goals].to_i 
    end.sum
    average_goals_per_hometeam = total_home_goals / home_games.length 
  end  

  def lowest_scoring_visitor 
    team_ids = @game_team_data[:team_id].uniq
    lowest_scoring_visitor = team_ids.min_by do |team_id|
      average_goals_by_visitor(team_id)
    end 
    team = @teams_data.find do |team|
      team[:team_id] == lowest_scoring_visitor
    end 
    team[:teamname] 
  end  
    
  def lowest_scoring_home_team
    team_ids = @game_team_data[:team_id].uniq
    highest_scoring_hometeam = team_ids.min_by do |team_id|
      average_goals_by_hometeam(team_id)
    end  
    team = @teams_data.find do |team|
      team[:team_id] == highest_scoring_hometeam
    end 
      team[:teamname] 
  end 
end 

