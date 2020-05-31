require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './game_collection'
require_relative './team_collection'
require_relative './game_teams_collection'
require 'csv'
require 'pry'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(info)
    @games = GameCollection.new(info[:games])
    @teams = TeamCollection.new(info[:teams])
    @game_teams = info[:game_teams]
  end

  def self.from_csv(info)
    StatTracker.new(info)
  end

  # Game Statistics Methods
  def highest_total_score
    games.all.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end.max
  end

  def lowest_total_score
    games.all.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end.min
  end

  def percentage_home_wins
    home_wins = 0
    games.all.each do |game|
      home_wins += 1 if game.home_goals.to_i > game.away_goals.to_i
    end
    (home_wins.to_f / games.all.size).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    games.all.each do |game|
      visitor_wins += 1 if game.away_goals.to_i > game.home_goals.to_i
    end
    (visitor_wins.to_f / games.all.size).round(2)
  end

  def percentage_ties
    ties = 0
    games.all.each do |game|
      ties += 1 if game.away_goals.to_i == game.home_goals.to_i
    end
    (ties.to_f / games.all.size).round(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    games.all.each do |game|
      games_by_season[game.season] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    average_goals = 0
    games.all.each do |game|
      average_goals += game.away_goals.to_i
      average_goals += game.home_goals.to_i
    end
    (average_goals.to_f / games.all.count).round(2)
  end

  #TeamStatisticsTest

  def self.from_csv(info)
    StatTracker.new(info)
  end

  def team_info(id)
    all_teams = @teams.all
    found_team = all_teams.find do |team|
      team.id == id
    end
    team_info_hash = {"team_id" => found_team.id,
      "franchise_id" => found_team.franchise_id,
      "team_name" => found_team.name,
      "abbreviation" => found_team.abbreviation,
      "link" => found_team.link
    }
    p team_info_hash
  end

  def total_games_per_team(team_id)
    total_games = 0
    games.all.count do |game|
    is_home_team = game.home_team_id == team_id
    is_away_team = game.away_team_id == team_id
    if is_home_team || is_away_team
       total_games += 1
    else
      0
    end
  end





    #end
    #hard code - for each team, per season, take percentage of wins / count of games per season
    #return season
  #   all_game_teams = GameTeamsCollection.new(@game_teams)
  #   win_team_id = []
  #   loss_team_id = []
  #   all_game_teams.all.each do |game_team|
  #     win_team_id << game_team.team_id if game_team.result == "WIN"
  #   win_team_id
  #     loss_team_id << game_team.team_id if game_team.result == "LOSS"
  #   end
  #   loss_team_id
  #
  #
  #   #wins = 0
  #   all_game_teams.all.map do |game_team|
  #     win_team_id.count
  #   binding.pry
  # end




    # found_gt = all_game_teams.all.select do |game_team|
    #   game_team if game_team.result == "WIN"
    # end
    # found_gt

    all_teams = TeamCollection.new(@teams)
    all_teams.all.each do |team|
      binding.pry
    end
  end
end
