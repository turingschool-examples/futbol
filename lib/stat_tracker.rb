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

  def percentage_visitor_wins
    count = 0
    game.each do |single_game|
      if single_game[:away_goals].to_i > single_game[:home_goals].to_i
        count +=1
      end
    end
    percentage = (count.to_f / game.length).round(2)
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

  def highest_total_score(testing = false)
    testing ? data = game.take(10) : data = game
    highest_score = 0
    data.each do |game|
      home_score = game[:home_goals].to_i 
      away_score = game[:away_goals].to_i
      total_score = home_score + away_score

      highest_score = total_score if total_score > highest_score
    end
    highest_score
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

  def games_and_scores
    games_and_scores = {}
    team_data.each do |team|
        games_and_scores[team[:team_id]] = {
          games_played: number_of_games(team[:team_id]),
          total_score: total_score_for_teams(team[:team_id]),
          average: (total_score_for_teams(team[:team_id])/number_of_games(team[:team_id]).to_f)
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

  def percentage_ties 
    count = 0
    game.each do |single_game|
      if single_game[:home_goals] == single_game[:away_goals] 
        count += 1
      end 
    end
    percentage = (count.to_f / game.count).round(2)
  end
  
  def lowest_total_score(testing = false)
    testing ? data = game.take(20) : data = game
    total_scores = data.map do |game|
      home_score = game[:home_goals].to_i 
      away_score = game[:away_goals].to_i
      total_score = home_score + away_score
    end
    total_scores.sort.first
  end

  def average_goals_per_game(testing = false)
    testing ? data = game_teams.take(20) : data = game_teams
    numerator = data.sum { |game| game[:goals].to_i }.to_f
    numerator / data.count
  end 

  def average_goals_by_season(testing = false)
    testing ? data = game.take(67) : data = game
    goals = Hash.new { |hash, season| hash[season] = [] }
    data.each do |game|
      season = game[:season]
      home_score = game[:home_goals].to_i 
      away_score = game[:away_goals].to_i
      total_score = home_score + away_score
      
      goals[season] << total_score
    end
    average_goals = goals.transform_values do |goals|
      (goals.sum.to_f / goals.length).round(2)
    end
    average_goals
  end

  def count_of_teams
    team_data.count
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
        number_of_games(team[:team_id]).to_f)
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

  def percentage_visitor_wins
    count = 0
    game.each do |single_game|
      if single_game[:away_goals].to_i > single_game[:home_goals].to_i
        count +=1
      end
    end
    percentage = (count.to_f / game.length).round(2)
  end

  def percentage_home_wins #(testing = false)
    #testing ? data = game.take(10) : data = game
    count = 0
    game.each do |single_game|
      if single_game[:home_goals].to_i > single_game[:away_goals].to_i
        count += 1
      end
    end
    percentage = (count.to_f / game.count).round(2)
    
  end

  def highest_total_score(testing = false)
    testing ? data = game.take(10) : data = game
    highest_score = 0
    data.each do |game|
      home_score = game[:home_goals].to_i 
      away_score = game[:away_goals].to_i
      total_score = home_score + away_score

      highest_score = total_score if total_score > highest_score
    end
    highest_score
  end 

  def count_of_games_by_season
    counts = Hash.new(0)
    game.each do |single_game|
      counts[single_game[:season]] += 1
    end
    counts
  end
end