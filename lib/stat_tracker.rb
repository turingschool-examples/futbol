# require 'csv'
require './spec/spec_helper'

class StatTracker 

  def initialize(locations)
    @@game = game_data_parser(locations[:games])
    @@team_data = team_data_parser(locations[:teams])
    @@game_teams = game_teams_data_parser(locations[:game_teams])
  end
  
  def game
    @@game
  end

  def team_data
    @@team_data
  end

  def game_teams
    @@game_teams
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def team_data_parser(file_location)
    contents = CSV.open file_location, headers: true, header_converters: :symbol
    contents.readlines
  end

  def game_data_parser(file_location)
    contents = CSV.open file_location, headers: true, header_converters: :symbol
    contents.readlines
  end

  def game_teams_data_parser(file_location)
    contents = CSV.open file_location, headers: true, header_converters: :symbol
    contents.readlines
  end

  def highest_total_score
    highest_score = 0
    game.each do |goals|
      home_score = goals[:home_goals].to_i 
      away_score = goals[:away_goals].to_i
      total_score = home_score + away_score

      highest_score = total_score if total_score > highest_score
    end
    highest_score
  end 

  def lowest_total_score
    total_scores = game.map do |game|
      home_score = game[:home_goals].to_i 
      away_score = game[:away_goals].to_i
      total_score = home_score + away_score
    end
    total_scores.sort.first
  end

  def percentage_home_wins 
    count = 0
    game.each do |single_game|
      if single_game[:home_goals].to_i > single_game[:away_goals].to_i
        count += 1
      end
    end
    percentage = (count.to_f / game.count).round(2)
    
  end

  def percentage_visitor_wins
    count = 0
    game.each do |single_game|
      if single_game[:away_goals].to_i > single_game[:home_goals].to_i
        count +=1
      end
    end
    percentage = (count.to_f / game.length).round(2)
  end

  def percentage_ties 
    count = 0
    game.each do |single_game|
      if single_game[:home_goals] == single_game[:away_goals] 
        count += 1
      end 
    end
    percentage = (count.to_f / game.count).round(2)
  end
  
  def count_of_games_by_season
    counts = Hash.new(0)
    game.each do |single_game|
      counts[single_game[:season]] += 1
    end
    counts
  end

  def average_goals_per_game
    numerator = game_teams.sum { |game| game[:goals].to_i }.to_f
    (numerator / game_teams.count).round(2)
  end

  def average_goals_by_season
    goals = Hash.new { |hash, season| hash[season] = [] }
    game.each do |single_game|
      season = single_game[:season]
      home_score = single_game[:home_goals].to_i 
      away_score = single_game[:away_goals].to_i
      total_score = home_score + away_score
      
      goals[season] << total_score
    end
    average_goals = goals.transform_values do |goal|
      (goal.sum.to_f / goal.length).round(2)
    end
    average_goals
  end

  def count_of_teams
    team_data.count
  end

  def best_offense
    team_number = games_and_scores.sort_by { |team, data| data[:average] }.last[0]
    
    best_offense = ""
    team_data.each do |team|
      if team[:team_id] == team_number
        best_offense << team[:teamname] 
      end
    end
    best_offense
  end

  def worst_offense
    worst_offense = ""
    team_number = games_and_scores.sort_by { |team, data| data[:average] }.first[0]
    team_data.each do |team|
      if team[:team_id] == team_number
        worst_offense << team[:teamname]
      end
    end 
    worst_offense
  end

  def games_and_scores
    games_and_scores = {}

    team_data.each do |team|
      games_and_scores[team[:team_id]] = {
        games_played: number_of_games(team[:team_id]),
        total_score: total_score_for_teams(team[:team_id]),
        average: (total_score_for_teams(team[:team_id])/
        number_of_games(team[:team_id]).to_f).round(2)
      }
    end
    games_and_scores
  end 

  def number_of_games(team)
    number_of_games = 0
    game_teams.each do |game|
      if game[:team_id] == team
        number_of_games += 1
      end 
    end
    number_of_games
  end

  def total_score_for_teams(team)
    total_score = 0
    game_teams.each do |game|
      if game[:team_id] == team
        total_score += game[:goals].to_i
      end 
    end
    total_score
  end

  def highest_scoring_home_team
    highest_score = ""
    team_number = home_team_games_scores.sort_by{ |team, data| data[:average] }.last[0]
    team_data.each do |team|
      if team[:team_id] == team_number
        highest_score << team[:teamname]
      end
    end 
    highest_score
  end

  def home_team_games_scores
    games_and_scores = {}
    home_team_games.each do |team|
      games_and_scores[team[:team_id]] = {
        games_played: home_team_games_count(team[:team_id]),
        total_score: home_game_total_score(team[:team_id]),
        average: (home_game_total_score(team[:team_id])/
        home_team_games_count(team[:team_id]).to_f)
      }
    end
    games_and_scores
  end

  def home_team_games
    home_team_games = []
    game_teams.each do |game|
      home_team_games << game if game[:hoa] == "home"
    end
    home_team_games
  end

  def home_team_games_count(team)
    number_of_games = 0
    home_team_games.each do |game|
      number_of_games += 1 if game[:team_id] == team
    end
    number_of_games
  end

  def home_game_total_score(team)
    total_score = 0
    home_team_games.each do |game|
      total_score += game[:goals].to_i if game[:team_id] == team
    end
    total_score
  end

  def lowest_scoring_home_team
    lowest_scoring = ""
    home_teams = games_and_scores.select { |team_id, data| home_team?(team_id) }
    lowest_avg = home_teams.sort_by { |team, data| data[:average] }.first[0]

    team_data.each do |team|
      if team[:team_id] == lowest_avg
        lowest_scoring << team[:teamname]
      end
    end 
    lowest_scoring
  end
  
  def home_team?(team_id)
    game_teams.find_all { |game_team| game_team[:team_id] == team_id && game_team[:hoa] == 'home' }
  end

  def lowest_scoring_visitor
    lowest = away_games_and_scores.sort_by { |team, data| data[:average] }.first[0]
    team_data.find { |row| row[:team_id] == lowest }[:teamname]
  end

  def away_games_and_scores
    away_games_hash = {}
    team_data.each do |team|
      away_games_hash[team[:team_id]] = {
        games_played: number_of_away_games(team[:team_id]),
        total_score: total_score_for_away_teams(team[:team_id]),
        average: (total_score_for_away_teams(team[:team_id])/
        number_of_away_games(team[:team_id]).to_f)
      }
    end
    away_games_hash
  end 

  def number_of_away_games(team)
    away_team_data = game_teams.select { |row| away_team?(row) }
    game_teams.count { |game| game[:team_id] == team }
  end

  def total_score_for_away_teams(team)
    away_team_data = game_teams.select { |row| away_team?(row) }
    total_score = 0
    away_team_data.each do |game|
      if game[:team_id] == team
        total_score += game[:goals].to_i
      end 
    end
    total_score
  end
  
  def away_team?(row)
    row[:hoa] == 'away'
  end
end
