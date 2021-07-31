require 'csv'
require './lib/game'

class GamesManager
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
  def highest_total_score
    highest_game = @games.max_by do |game|
      game.away_goals + game.home_goals
    end
    highest_game.away_goals + highest_game.home_goals
  end

  #Interface
  def lowest_total_score
    lowest_game = @games.min_by do |game|
      game.away_goals + game.home_goals
    end
    lowest_game.away_goals + lowest_game.home_goals
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
    team_id = home_info.each.max_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_id
  end

#Interface
  def lowest_scoring_home_team
    home_info = get_home_team_goals
    team_id = home_info.each.min_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_id
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
      data[:goals].fdiv(data[:total])
    end.first
    team_id
  end

#Interface
  def lowest_scoring_visitor
    visitor_info = get_visitor_goals
    team_id = visitor_info.each.min_by do |team, data|
      data[:goals].fdiv(data[:total])
    end.first
    team_id
  end

  # Interface
  def average_win_percentage(team_id)
    wins = 0
    games = 0
    seasons_win_count(team_id, @games).each do |season, stats|
      wins += stats[:wins]
      games += stats[:total]
    end
    (wins.fdiv(games)).round(2)
  end

  # We send team_id, they return hash with opp_id & results against
  def opponent_win_count(team_id)
    win_loss = {}
    @games.each do |game|
      if game[:home_team_id] == team_id || game[:away_team_id] == team_id
        data = get_home_or_away(team_id, game)

        win_loss[data[:opp_id]] ||= {wins: 0, total: 0}
        if data[:team_goals] > data[:opp_goals]
          win_loss[data[:opp_id]][:wins] += 1
        end
        win_loss[data[:opp_id]][:total] += 1
      end
    end
    win_loss
  end

  ########
  # Interface
  def favorite_opponent(team_id)
    win_loss = calculate_win_percents(team_id)
    fav_team = win_loss.max_by do |team, result|
      result
    end.first

    team_info(fav_team)["team_name"]
  end
  # Interface
  def rival(team_id)
    win_loss = calculate_win_percents(team_id)
    rival_team = win_loss.min_by do |team, result|
      result
    end.first

    team_info(rival_team).team_name
  end

  # Helper
  def calculate_win_percents(team_id)
    win_loss = opponent_win_count(team_id)
    win_loss.map do |team, results|
      avg = results[:wins].fdiv(results[:total])
      [team, avg]
    end.to_h
  end

  def percentage_home_wins
    home_game_wins = 0
    total_games = 0
    @games.each do |game|
      total_games += 1
      if game[:home_goals] > game[:away_goals]
        home_game_wins += 1
      end
    end
    (home_game_wins.fdiv(total_games)).round(2)
  end

  def percentage_visitor_wins
    visitor_game_wins = 0
    total_games = 0
    @games.each do |game|
      total_games += 1
      if game[:home_goals] < game[:away_goals]
        visitor_game_wins += 1
      end
    end
    (visitor_game_wins.fdiv(total_games)).round(2)
  end

  def percentage_ties
    ties = 0
    total_games = 0
    @games.each do |game|
      total_games += 1
      if game[:home_goals] == game[:away_goals]
        ties += 1
      end
    end
    (ties.fdiv(total_games)).round(2)
  end

end
