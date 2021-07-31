require 'csv'
require_relative 'game'
require_relative 'mathable'

class GamesManager
  include Mathable
  attr_reader :games

  def initialize(file_path)
    @games = []
    make_games(file_path)
  end

# helper
  def make_games(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      @games << Game.new(row)
    end
  end

#Interface
  def score_results(min_max)
    min_max_game = {
      max: -> { @games.max_by { |game| game.total_goals } },
      min: -> { @games.min_by { |game| game.total_goals } }
    }
    game = min_max_game[min_max].call
    game.total_goals
  end

  #Interface
  def count_of_games_by_season
    count_seasons = Hash.new(0)
    @games.each do |game|
      count_seasons[game.season] += 1
    end
    count_seasons
  end

##Interface
  def average_goals_by_season
    goals_per_season.reduce({}) do |acc, season_goals|
      acc[season_goals[0]] = season_goals[1].fdiv(games_per_season(season_goals[0])).round(2)
      acc
    end
  end

  ##helper
  def goals_per_season
    goals = {}
    @games.each do |game|
      goals[game.season] ||= 0
      goals[game.season] += goals_per_game(game)
    end
    goals
  end

  ##helper
  def goals_per_game(game)
    game.away_goals + game.home_goals
  end

##Interface
  def average_goals_per_game
    goals = @games.sum do |game|
      game.away_goals + game.home_goals
    end
    (goals.fdiv(@games.size)).round(2)
  end

  ##Interface
  def games_per_season(season)
    @games.count do |game|
      game.season == season
    end
  end

  #Helper
  def get_home_team_goals
    home_avg = {}
    @games.each do |game|
      home_avg[game.home_team_id] ||= { goals: 0, total: 0 }
      home_avg[game.home_team_id][:goals] += game.home_goals
      home_avg[game.home_team_id][:total] += 1
    end
    home_avg
  end

#Interface
  def highest_scoring_home_team
    home_info = get_home_team_goals
     home_info.each.max_by do |team, data|
      average(data)
    end.first
  end

#Interface
  def lowest_scoring_home_team
    home_info = get_home_team_goals
    home_info.each.min_by do |team, data|
      average(data)
    end.first
  end

  #Helper
  ##same as get_awway_team_goals in GameTeamsMgr
  def get_visitor_goals
    visitor_avg = {}
    @games.each do |game|

      visitor_avg[game.away_team_id] ||= { goals: 0, total: 0 }
      visitor_avg[game.away_team_id][:goals] += game.away_goals
      visitor_avg[game.away_team_id][:total] += 1
    end
    visitor_avg
  end

#Interface
  def highest_scoring_visitor
    visitor_info = get_visitor_goals
    team_id = visitor_info.each.max_by do |team, data|
      average(data)
    end.first
    team_id
  end

#Interface
  def lowest_scoring_visitor
    visitor_info = get_visitor_goals
    team_id = visitor_info.each.min_by do |team, data|
      average(data)
    end.first
    team_id
  end

  # We send team_id, they return hash with opp_id & results against
  # Helper
  def opponent_win_count(team_id)
    @games.reduce({}) do |acc, game|
      if game.has_team?(team_id)
        opp_id = opponent_id(team_id, game)

        acc[opp_id] ||= {wins: 0, total: 0}
        if !game.winner?(team_id)
          acc[opp_id][:wins] += 1
        end
        acc[opp_id][:total] += 1
      end
      acc
    end
  end

  def opponent_id(team_id, game)
    if game.home_team?(team_id)
      game.away_team_id
    else
      game.home_team_id
    end
  end

  ########
  # Interface
  def favorite_opponent(team_id)
    win_loss = calculate_win_percents(team_id)
    win_loss.min_by do |team, result|
      result
    end.first
  end
  # Interface
  def rival(team_id)
    win_loss = calculate_win_percents(team_id)
    win_loss.max_by do |team, result|
      result
    end.first
  end

  # Helper
  def calculate_win_percents(team_id)
    win_loss = opponent_win_count(team_id)
    win_loss.map do |team, results|
      [team, average(results)]
    end
  end
end
