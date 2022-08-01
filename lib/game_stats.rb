require "csv"
require "stat_tracker"
require "pry"

class GameStats
  def initialize(data)
    @games = data.games
    @teams = data.teams
    @game_teams = data.game_teams
  end

  def highest_total_score
    all_goals.max
  end

  def lowest_total_score
    all_goals.min
  end

  def percentage_home_wins
    home_wins = []
    all_home_games = []

    @game_teams.each do |row|
      home_wins << row if row[:hoa] == "home" && row[:result] == "WIN"
      all_home_games << row if row[:hoa] == "home"
    end

    ((home_wins.count / all_home_games.count.to_f).round(2))
  end

  def percentage_visitor_wins
    vistor_wins = []
    all_vistor_games = []

    @game_teams.each do |row|
      vistor_wins << row if row[:hoa] == "away" && row[:result] == "WIN"
      all_vistor_games << row if row[:hoa] == "away"
    end

    ((vistor_wins.count / all_vistor_games.count.to_f).round(2))
  end

  def percentage_ties
    ties = []
    all_games = []

    @game_teams.each do |row|
      ties << row if row[:result] == "TIE"
      all_games << row[:result]
    end

    ((ties.count / all_games.count.to_f).round(2))
  end

  def count_of_games_by_season
    #hash
    game_count_by_season = Hash.new { 0 }

    @games.each do |game|
      season_key = game[:season]

      if game_count_by_season[season_key].nil?
      end

      game_count_by_season[season_key] += 1
    end

    game_count_by_season
  end

  def total_games
    count_of_games_by_season.values.sum
  end

  def average_goals_per_game
    (total_goals / total_games.to_f).round(2)
  end

  def average_goals_by_season
    total_games_per_season = Hash.new { |hash, season| hash[season] = [] }

    @games.each do |game|
      home_goals = game[:home_goals].to_i
      away_goals = game[:away_goals].to_i
      total_game_goals = (home_goals + away_goals)
      total_games_per_season[game[:season]] << total_game_goals
    end

                                                                                      #-------refactor this------------------------#
    average_games_per_season = total_games_per_season.map { |season, games| [season, (games.sum / games.size.to_f).round(2)] }.to_h
    require "pry"

    binding.pry
  end

  private

  def all_goals
    #array of all goals
    goals = @games.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end

    goals
  end

  def total_goals
    home_goals = 0
    away_goals = 0
    total_goals = 0

    @games.each do |game|
      home_goals += game[:home_goals].to_i
      away_goals += game[:away_goals].to_i
    end

    total_goals = (home_goals + away_goals)
  end

  def helper
    my_hash = Hash.new { |h, k| h[k] = [] }
    my_hash[:some_key] << new_value

    if row[:hoa] == "home" && row[:result] == "WIN"
      team_record[:hoa][:wins] += 1
      ((home_wins.count / all_home_games.count.to_f).round(2))
    elsif row[:hoa] == "away" && row[:result] == "WIN"
      team_record[:hoa][:losses] += 1
      ((vistor_wins.count / all_vistor_games.count.to_f).round(2))
    elsif row[:result] == "TIE"
      team_record[:hoa][:ties] += 1
      ((ties.count / all_games.count.to_f).round(2))
    end

    team_record = Hash.new { |h, k| h[k] = {wins: 0, losses: 0, ties: 0} }
  end
end
