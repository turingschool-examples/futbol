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
    teams = @teams_data.map do |team|
      team 
    end 
    teams.size 
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
    end
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
    
  
