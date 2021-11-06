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
    @game_hash = {}
    @game_teams_hash = {}
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
      @game_hash[row['game_id']] = GameStats.new(row)
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
      @game_teams_hash[row["team_id"]] = GameTeams.new(row)
    end
  end

  def highest_total_score
    max_score = 0
    @game_hash.each_value do |game|
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
    agbs = count_of_games_by_season
    agbs.transform_values! do |season_games|
      [season_games, 0]
    end
    @games_path.each do |game|
      agbs[game.season_id][1] += game.home_goals
      agbs[game.season_id][1] += game.away_goals
    end
    agbs.transform_values do |season_games|
      (season_games[1] / season_games[0].to_f).round(2)
    end
  end
end
