require 'csv'
require 'simplecov'
require_relative './game_stats'
require_relative './league_stats.rb'
require_relative './season_stats.rb'
require_relative './team_stats.rb'

SimpleCov.start

class StatTracker
  attr_accessor :game_teams_path, :teams_path, :games_path

  def initialize(locations)
    @games_path = games(locations[:games])
    # @teams_path = teams(locations[:teams])
    # @game_teams_path = game_teams(locations[:game_teams])
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def games(game_stats)
    rows = CSV.read(game_stats, headers: true)
    rows.map do |row|
      GameStats.new(row)
    end
  end

  def teams(team_stats)
    rows = CSV.read(game_stats, headers: true)
    rows.map do |row|
      TeamStats.new(row)
    end
  end


  def game_teams(game_teams_stats)
    rows = CSV.read(game_stats, headers: true)
    rows.map do |row|
      GameTeams.new(row)
    end
  end

  def highest_total_score
    max_score = 0
    @games_path.each do |game|
      sum = game.away_goals + game.home_goals
      if sum > max_score
        max_score = sum
      end
    end
    max_score
  end

  def lowest_total_score
     low_score = 100
     @games_path.each do |game|
       sum = game.away_goals + game.home_goals
       if sum < low_score
         low_score = sum
       end
     end
     low_score
   end

   def percentage_home_wins
    home_wins = 0
    total_game = 0
    @games_path.each do |game|
      total_game += 1
      if game.home_goals > game.away_goals
        home_wins += 1
      else
      end
    end
    x = (home_wins.to_f / total_game.to_f).round(2)
  end

  def percentage_visitor_wins
    away_wins = 0
    total_game = 0
    @games_path.each do |game|
      total_game += 1
      if game.away_goals > game.home_goals
        away_wins += 1
      else
      end
    end
    x = (away_wins.to_f / total_game.to_f).round(2)
  end

  def percentage_ties
    total_game = 0
    total_ties = 0
    @games_path.each do |game|
      total_game += 1
      if game.home_goals == game.away_goals
        total_ties += 1
      else
      end
    end
    x = (total_ties.to_f / total_game.to_f).round(2)
  end

  def count_of_games_by_season
    tgps = Hash.new(0)
    @games_path.each do |game|
      tgps[game.season_id] += 1
    end
    tgps
  end

  def average_goals_per_game
    total_game = 0.0
    away_goals = 0.0
    home_goals = 0.0
    @games_path.each do |game|
      total_game += 1
      away_goals += (game.away_goals).to_f
      home_goals += (game.home_goals).to_f
    end
    sum = away_goals + home_goals
    avg_goal_per_game = sum / total_game
    avg_goal_per_game.round(2)
  end

  def average_goals_by_season
     avg = {}
     count_of_games_by_season.each_pair do |season, games|
       avg[season] = (total_goals(season) / games).round(2)
     end
     avg
   end

   def season_games
     @games_path.group_by do |game|
       game.season_id
     end
   end

   def total_goals(season)
     (total_away_goals(season) + total_home_goals(season)).sum
   end

   def total_away_goals(season)
     away = @games_path.select do |game|
       game.include?(season)
     end

     away.map do |goal|
       goal.to_f
     end
   end

   def total_home_goals(season)
     home = @games_path.select do |game|
       @games_path.include?(season)
     end
     home.map do |goal|
       goal.to_f
     end
   end
 end
 # #
  # def average_goals_by_season
  #   avg = 0.0
  #   total = 0.0
  #   avg_hash = Hash.new(0)
  #   @games_path.group_by do |game|
  #     count_of_games_by_season.each do |sea|
  #       require "pry"; binding.pry
  #       if game.season_id == sea[0]
  #         total = (game.away_goals + game.home_goals).to_f
  #       end
  #       avg = (total / sea.last.to_f).round(2)
  #       avg_hash[sea.first] = avg
  #     end
  #   end
  #   avg_hash
  # end





  # def percentage_home_wins
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.percentage_home_wins
  # end
  #
  # def percentage_visitor_wins
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.percentage_visitor_wins
  # end
  #
  # def percentage_ties
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.percentage_ties
  # end
  #
  # def count_of_games_by_season
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.count_of_games_by_season
  # end
  #
  # def average_goals_per_game
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.average_goals_per_game
  # end
  #
  # def average_goals_by_season
  #   game_stats = GameStats.new(@games_path)
  #   game_stats.average_goals_per_season
  # end
  #
  #
  # def count_of_teams
  #   league_stats = LeagueStats.new(@game_teams_path)
  #   league_stats.count_of_teams
  # end
