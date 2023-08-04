require 'csv'

class LeagueStatistics
  attr_reader :locations,
  :teams_data,
  :game_data,
  :game_team_data

  def initialize(locations)
    @locations = locations
    @game_data = CSV.open locations[:games], headers: true, header_converters: :symbol
    @teams_data = CSV.open locations[:teams], headers: true, header_converters: :symbol
    @game_team_data = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
  end


  def count_of_teams 
    teams = @teams_data.map do |team|
      team 
    end 
    teams.size 
  end

  def best_offense

    offense = Hash.new { |hash, key| hash[key] = [] }
    
    @game_team_data.each do |row|
      team = row[:team_id].to_i
      goals = row[:goals].to_i
      offense[team] << goals
 
    end

    best_offense_team_id = nil
    highest_average_goals = -1

    offense.each do |team_id, goals|
      average_goals = goals.sum.to_f / goals.size
      if average_goals > highest_average_goals
        highest_average_goals = average_goals
        best_offense_team_id = team_id
      end
    end

    best_offense_team = nil

    @teams_data.each do |row|
      if row[:team_id].to_i == best_offense_team_id
        best_offense_team = row[:teamName]
      end 
    end

    best_offense_team
  end

  def worst_offense_team 
    
    
    team_ids = @game_team_data.map do |team| 
       team[:team_id] 
    end

    team_ids = team_ids.uniq

    lowest_scoring_team = team_ids.min_by do |team_id|
          average_goals_for_team(team_id)
    end  

    team = @teams_data.find do |team|
      team[:team_id] == lowest_scoring_team
    end 

    team[:teamName]  
  end 
  
  def average_goals_for_team(team_id)
    binding.pry
    games = @game_team_data.find_all do |game_team|
      game_team[:team_id] == team_id    
    end 

    # total_goals = games.map do |game|
    #   game[:goals].to_i 
    # end.sum
    #  

    # average_goals_per_season = total_goals / games.length 
  end  
end 
      