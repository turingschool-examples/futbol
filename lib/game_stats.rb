require_relative 'game'
require_relative 'team_stats'
require_relative 'data_loadable'

class GameStats
  include DataLoadable
  attr_reader :games

  def initialize(file_path, object)
    @games = csv_data(file_path, object)
  end

  def percentage_ties
    ties = @games.count do |game|
      game.away_goals == game.home_goals
    end
    ties.fdiv(@games.length).round(2)
  end

  def count_of_games_by_season
    #sort by number/games_by_season
    @games.reduce(Hash.new(0)) do |games_by_season, game|
      games_by_season[game.season.to_s] += 1
      games_by_season
    end
  end

  def percentage_home_wins
    home_wins = @games.find_all { |game| game.away_goals < game.home_goals }
    sum = (home_wins.length).to_f / (@games.length).to_f
    sum.round(2)
  end

  def percentage_visitor_wins
    vistor_wins = @games.find_all { |game| game.away_goals > game.home_goals }
    sum = (vistor_wins.length).to_f / (@games.length).to_f
    sum.round(2)
  end

  def average_goals_per_game
    all_goals = @games.sum { |game| game.away_goals + game.home_goals }
    sum = all_goals.to_f / @games.length
    sum.round(2)
  end

  def average_goals_by_season
    goals_per_season = {}
    @games.each do |game|
      if goals_per_season[game.season] == nil
        goals_per_season[game.season] = game.away_goals + game.home_goals
      else
        goals_per_season[game.season] += game.away_goals + game.home_goals
      end
    end
    count = count_of_games_by_season
    @games.reduce(Hash.new(0)) do |average_goals, game|
      average_goals[game.season.to_s] = (goals_per_season[game.season].to_f / count[game.season.to_s]).round(2)
      average_goals
    end
  end

  def highest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.max
  end

  def lowest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.min
  end

  def biggest_blowout
    @games.map { |game| (game.away_goals - game.home_goals).abs }.max
  end

  def winningest_team
    win_ratios = Hash.new { |hash, key| hash[key] = [0,0] }
    @games.each do |game|
      if game.away_goals > game.home_goals
        win_ratios[game.away_team_id][0] += 1
      end
      if game.home_goals > game.away_goals
        win_ratios[game.home_team_id][0] += 1
      end
      win_ratios[game.away_team_id][1] += 1
      win_ratios[game.home_team_id][1] += 1
    end

    win_percentages = win_ratios.each_with_object(Hash.new) do |(team_id, win_ratio), win_percent|
      win_percent[team_id] = win_ratio[0].fdiv(win_ratio[1]) * 100
    end

    team_id = win_percentages.key(win_percentages.values.max)
    team_id
  end
end
