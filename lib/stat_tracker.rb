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

  # Methods for League Statistics

  def best_offense(testing = false)
    testing ? data = game_teams.take(10) : data = game_teams
    games_and_scores = {}
    data.each do |team|
      games_and_scores[team[:team_id]] = {
        games_played: nil,
        total_score: nil,
      }
      # require 'pry'; binding.pry
    end
    games_and_scores

    # name of the team with best average goals
    # need team id and goals
    # need sum of games played
    # divide goals/games played
    # link the team id to the team name 



    number_of_games = Hash.new(0)
    data.each do |team|
      number_of_games[team[:team_id]] += 1
    end
    number_of_games
    require 'pry'; binding.pry

    # highest_average_goals = {}
    # number_of_games.each do |team_id, num_games|
    #   average_score = total_score/num_games.to_f
    #   highest_average_goals[team_id] = average_score
    # end
    # highest_average_goals
    # require 'pry'; binding.pry
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
end