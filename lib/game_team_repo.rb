require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class GameTeamRepo
  attr_reader :game_teams,
              :teams

  def initialize(locations)
    @game_teams = GameTeam.read_file(locations[:game_teams])
    @teams = Team.read_file(locations[:teams])
  end

  def average_goals_team
    total_goals_by_team = Hash.new(0)
    @game_teams.each do |game_team|
      total_goals_by_team[game_team.team_id] = [game_team.goals.to_i]
    end
    total_goals_by_team 

    avg_goals_by_team = Hash.new(0)
    total_goals_by_team.each do |id, total_goals|
      total_goals.each do |total_goal|
       avg_goals_by_team[id] = (total_goal.to_f / @game_teams.find_all { |game| game.team_id == id }.length.to_f).round(2)
      end
    end
    avg_goals_by_team
  end

  def highest_avg_goals_by_team
    average_goals_team.max_by do |game, goals|
      goals
    end.first
  end

  def lowest_avg_goals_by_team
    average_goals_team.min_by do |game, goals|
      goals
    end.first
  end

  def highest_scoring_home_team
    team_total_goals = Hash.new (0)
    @game_teams.each do |game|
        (team_total_goals[game.team_id] += game.goals.to_i) if game.hoa == "home" 
    end
    
    team_total_goals.update(team_total_goals) do |team_id, away_games|
        team_total_goals[team_id].to_f / @game_teams.find_all { |game| game.hoa == "home" && game.team_id == team_id}.length
    end
    
    highest_home_team_id = team_total_goals.key(team_total_goals.values.max)
    
    highest_home_team = @teams.find { |team| team.team_name if team.team_id == highest_home_team_id }
    highest_home_team.team_name
  end

end