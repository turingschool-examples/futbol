# require_relative './spec/spec_helper'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'season'
require 'csv'
require_relative 'team_accuracy'
require_relative 'offensive'
require_relative 'tackle_counter'

class StatTracker 
  include TeamAccuracy
  include Offensive
  include TackleCounter

  attr_reader :data, 
              :teams, 
              :games, 
              :game_teams,
              :seasons_by_id

  def initialize(data)
    @data = data
    @teams = processed_teams_data(@data)
    @games = processed_games_data(@data)
    @game_teams = processed_game_teams_data(@data)
    @seasons_by_id = processed_seasons_data
  end
  
  def self.from_csv(locations)
    new_locations = {}
    locations.each do |key,value|
      new_locations[key] = CSV.open value, headers: true, header_converters: :symbol
    end
    new(new_locations)
  end
  
  def processed_teams_data(locations)
    all_teams = []
    teams = @data[:teams]
    teams.each do |row|
      all_teams << Team.new(row)
    end
    @teams = all_teams
  end
  
  def processed_games_data(locations)
    all_games = []
    games = @data[:games]
    games.each do |row|
      all_games << Game.new(row)
    end
    @games = all_games
  end

  def processed_game_teams_data(locations)
    all_game_teams = []
    game_teams = @data[:game_teams]
    game_teams.each do |row|
      all_game_teams << GameTeam.new(row)
    end
    @game_teams = all_game_teams
  end

  def processed_seasons_data
    all_seasons = Hash.new
    @games.map{|game| game.season}.uniq.each do |season_id|
      new_season = Season.new(season_id, @games, @game_teams)
      all_seasons[season_id] = new_season.season_data
    end
    all_seasons
  end

  def percentage_home_wins
    home_teams = @game_teams.select do |team|
      team.hoa == "home"
    end
    winning_teams = home_teams.select do |team|
      team.result == "WIN"
    end
    percentage_wins = winning_teams.count / home_teams.count.to_f
    percentage_wins.round(2)
  end

  def percentage_visitor_wins
    visitor_teams = @game_teams.select do |team|
      team.hoa == "away"
    end
    winning_teams = visitor_teams.select do |team|
      team.result == "WIN"
    end
    percentage_wins = winning_teams.count / visitor_teams.count.to_f
    percentage_wins.round(2)
  end
  
  def percentage_ties
    games_tied = @game_teams.select do |game|
      game.result == "TIE"
    end
    games_tied_float = games_tied.count / @game_teams.count.to_f
    games_tied_float.round(2)
  end

  def highest_total_score
    highest_goal = @games.max_by do |game|
      game.away_goals + game.home_goals 
    end
    highest_goal.away_goals + highest_goal.home_goals
  end

  def lowest_total_score
    lowest_goals = @games.min_by do |game|
      game.away_goals + game.home_goals 
    end
    lowest_goals.away_goals + lowest_goals.home_goals
  end

  def average_goals_per_game
    total_goals = 0
    total_games = @games.count
      @games.each do |game|
      total_goals += game.away_goals + game.home_goals
    end
    (total_goals.to_f / total_games).round(2)
  end

  def count_of_teams
    @teams.count
  end

  def winningest_coach(season_id)
    season_games = @seasons_by_id[season_id][:game_teams]
    games_won_coach = Hash.new(0)
    games_played_coach = Hash.new(0)
    coach_win_percentage = Hash.new
    season_games.each do |game|
      games_played_coach[game.head_coach] += 1
      if game.result == "WIN"
      games_won_coach[game.head_coach] += 1
      end
    end
    games_played_coach.each do |coach, games|
      games_won_coach.each do |won_coach, won_games|
      if coach == won_coach
        coach_win_percentage[coach] = (won_games / games.to_f)
        end
      end
    end
    coach_win_percentage.max_by {|coach, percentage| percentage}[0]
  end
  
  def count_of_games_by_season
    games_count = {}
    @seasons_by_id.keys.map do |season_id| 
      games_count[season_id] = @seasons_by_id[season_id][:games].length
    end
    games_count
  end

  def average_goals_by_season
    goals = Hash.new(0)
    @seasons_by_id.each do |season, season_info|
        goals[season] = (season_info[:game_teams].sum{|game_team| game_team.goals.to_f} / 
                        (season_info[:game_teams].length / 2).to_f).round(2)
    end
    goals
  end

  def most_accurate_team(season_id)
    @teams.find{|team| team.team_id == find_accuracy_ratios(season_id).max_by{|team,ratio| ratio}.first}.teamname 
  end

  def least_accurate_team(season_id)
    @teams.find{|team| team.team_id == find_accuracy_ratios(season_id).min_by{|team,ratio| ratio}.first}.teamname
  end

  def worst_coach(season_id)
    season_games = @seasons_by_id[season_id][:game_teams]
    games_won_coach = Hash.new(0)
    games_played_coach = Hash.new(0)
    coach_win_percentage = Hash.new
    season_games.each do |game|
      games_played_coach[game.head_coach] += 1
      if game.result == "WIN"
      games_won_coach[game.head_coach] += 1
      end
    end
    games_played_coach.each do |coach, games|
      games_won_coach.each do |won_coach, won_games|
        if coach == won_coach
          coach_win_percentage[coach] = (won_games / games.to_f)
        end
        if !games_won_coach.include?(coach)
        coach_win_percentage[coach] = 0
        end
      end
    end
    coach_win_percentage.min_by {|coach, percentage| percentage}[0]
  end




  def highest_scoring_home_team
    team_scores = Hash.new(0)
    home_games = {}
    team_names = {}
    team_ids = @games.map do |game|
      game.home_team_id
    end
    team_ids.each do |team_id|
      home_games[team_id] = @games.select {|game| game.home_team_id == team_id}
      team_scores[team_id] = (home_games[team_id].sum {|game| game.home_goals.to_f} / home_games[team_id].length.to_f)
    end

    highest_team = @teams.find {|team| team.team_id == team_scores.max_by {|team, score| score}.first}.teamname
    @teams.each do |team|
      team_names[team.team_id] = team.teamname
    end
    return highest_team
  end  

  def highest_scoring_visitor
    team_scores = Hash.new(0)
    away_games = {}
    team_names = {}
    team_ids = @games.map do |game|
      game.away_team_id
    end
    team_ids.each do |team_id|
      away_games[team_id] = @games.select {|game| game.away_team_id == team_id}
      team_scores[team_id] = (away_games[team_id].sum {|game| game.away_goals.to_f} / away_games[team_id].length.to_f)
    end

    highest_team = @teams.find {|team| team.team_id == team_scores.max_by {|team, score| score}.first}.teamname
    @teams.each do |team|
      team_names[team.team_id] = team.teamname
    end
    return highest_team
  end  


  def best_offense 
    best_offense = offensive.max_by {|id,avg_goals| avg_goals} 
    best_team = @teams.find {|team| team.team_id == best_offense.first}.teamname
  end

  def worst_offense 
    worst_offense = offensive.min_by {|id,avg_goals| avg_goals} 
    worst_team = @teams.find {|team| team.team_id == worst_offense.first}.teamname
  end

  def lowest_scoring_visitor
    team_names = Hash.new
    teams_total_score = Hash.new(0)
    teams_total_games = Hash.new(0)
    teams_goals_per_game = Hash.new
    @teams.each do |team|
      team_names[team.team_id] = team.teamname
    end
    @game_teams.each do |game|
      if game.hoa == "away"
        teams_total_games[game.team_id] += 1
        teams_total_score[game.team_id] += game.goals.to_i
      end
    end
    teams_total_games.each do |team_id, games|
     teams_total_score.each do |team_id_score, goals|
        if team_id_score == team_id
          teams_goals_per_game[team_id] = (goals / games.to_f)
        end
      end
    end
    lowest_scoring_team = teams_goals_per_game.min_by { |team, goal_percentage| goal_percentage}[0]
    team_names.find { |team_id, team_name| team_id == lowest_scoring_team}[1]
  end

  def lowest_scoring_home_team
    team_names = Hash.new
    teams_total_score = Hash.new(0)
    teams_total_games = Hash.new(0)
    teams_goals_per_game = Hash.new
    @teams.each do |team|
      team_names[team.team_id] = team.teamname
    end
    @game_teams.each do |game|
      if game.hoa == "home"
        teams_total_games[game.team_id] += 1
        teams_total_score[game.team_id] += game.goals.to_i
      end
    end
    teams_total_games.each do |team_id, games|
     teams_total_score.each do |team_id_score, goals|
        if team_id_score == team_id
          teams_goals_per_game[team_id] = (goals / games.to_f)
        end
      end
    end
    lowest_scoring_team = teams_goals_per_game.min_by { |team, goal_percentage| goal_percentage}[0]
    team_names.find { |team_id, team_name| team_id == lowest_scoring_team}[1]
  end

  def most_tackles(season_id)
    @teams.find{|team| team.team_id == count_tackles(season_id).max_by {|team_id, tackles| tackles}.first}.teamname
  end

  def fewest_tackles(season_id)
    @teams.find{|team| team.team_id == count_tackles(season_id).min_by {|team_id, tackles| tackles}.first}.teamname
  end

end

      
  
      

