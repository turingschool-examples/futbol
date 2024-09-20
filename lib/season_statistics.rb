require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class SeasonStatistics
    attr_reader :games, :teams, :game_teams, :stat_tracker
  
    def initialize(games, teams, game_teams, stat_tracker)
      @games = games
      @teams = teams
      @game_teams = game_teams
      @stat_tracker = stat_tracker
    end
  
    def most_accurate_team
      goals = Hash.new(0)
      shots = Hash.new(0)
  
      @game_teams.each do |game| #gets goals and shots for each team
        team_id = game[:team_id]
        goals[team_id] += game[:goals].to_i
        shots[team_id] += game[:shots].to_i
      end
  
      most_accurate_team_id = goals.keys.max_by do |team_id|
        accuracy(goals[team_id], shots[team_id]) #calculates accuracy for each team and then finds most accurate
      end
  
      find_team_name(most_accurate_team_id)
    end
  
    def accuracy(goals, shots)
      (goals.to_f / shots) * 100
    end
  
    def least_accurate_team
      goals = Hash.new(0)
      shots = Hash.new(0)
  
      @game_teams.each do |game| #gets goals and shots for each team
        team_id = game[:team_id]
        goals[team_id] += game[:goals].to_i
        shots[team_id] += game[:shots].to_i
      end
  
      least_accurate_team_id = goals.keys.min_by do |team_id|
        accuracy(goals[team_id], shots[team_id]) #calculates accuracy for each team and then finds least accurate
      end
  
      find_team_name(least_accurate_team_id)
    end
  
    def winningest_coach
      total_games = Hash.new(0)
      wins = Hash.new(0)
  
      @teams.each do |game|
        coach = game[:head_coach]
        total_games[coach] += 1
        wins[coach] += 1 if game[:result] == 'WIN'
      end
  
      highest_percentage_coach = total_games.keys.max_by do |coach|
        win_percentage(wins[coach], total_games[coach])
      end
  
      highest_percentage_coach
    end
  
    def worst_coach
      total_games = Hash.new(0)
      wins = Hash.new(0)
  
      @game_teams.each do |game|
        coach = game[:head_coach]
        total_games[coach] += 1
        wins[coach] += 1 if game[:result] == 'WIN'
      end
  
      lowest_percentage_coach = total_games.keys.min_by do |coach|
        win_percentage(wins[coach], total_games[coach])
      end
  
      lowest_percentage_coach
    end
  
    def fewest_tackles
      tackles_teams = Hash.new(0)
      @game_teams.each do |game|
        team_id = game[:team_id]
        tackles_teams[team_id] += game[:tackles].to_i
      end
  
      team_fewest_tackles = tackles_teams.min_by { |team, tackles| tackles }[0]
  
      find_team_name(team_fewest_tackles)
    end
  
    def most_tackles
      tackles_teams = Hash.new(0)
      @game_teams.each do |game|
        team_id = game[:team_id]
        tackles_teams[team_id] += game[:tackles].to_i
      end
  
      team_most_tackles = tackles_teams.max_by { |team, tackles| tackles }[0]
  
      find_team_name(team_most_tackles)
    end
  
    def win_percentage(wins, total)
      return 0 if total == 0
      (wins.to_f / total) * 100
    end
  
    def find_team_name(team_id)
      team = @teams.find { |team| team.team_id == team_id }
      team.team_name
    end
  end
  
