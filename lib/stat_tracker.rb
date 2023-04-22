require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'


class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data_hash)
    @games = data_hash[:games]
    @teams = data_hash[:teams]
    @game_teams = data_hash[:game_teams]
  end

  def self.from_csv(database_hash)
    data_hash = { :games => [], :teams => [], :game_teams => [] }

    if database_hash.keys.include?(:games)
      games = CSV.read(database_hash[:games], headers: true, header_converters: :symbol).each do |row|
        data_hash[:games] << Game.new(row)
      end
    end

    if database_hash.keys.include?(:teams)
      teams = CSV.read(database_hash[:teams], headers: true, header_converters: :symbol).each do |row|
        data_hash[:teams] << Team.new(row)
      end
    end

    if database_hash.keys.include?(:game_teams)
      game_teams = CSV.read(database_hash[:game_teams], headers: true, header_converters: :symbol).each do |row|
        data_hash[:game_teams] << GameTeams.new(row)
      end
    end
    new(data_hash)
  end

  def highest_total_score
      max_game = @games.max_by do |game|
        game.home_goals + game.away_goals
      end
      max_game.home_goals + max_game.away_goals
  end

  def average_goals_per_game
    goals = 0
    total_games = @games.count
    avg_goals = @games.each { |game| goals += game.away_goals + game.home_goals }
    (goals.to_f / total_games).round(2)
  end

  def average_goals_by_season
    season_name = @games.group_by {|game| game.season }.transform_values do |games|
      total_goals = games.sum { |game| game.away_goals + game.home_goals }
      (total_goals.to_f / games.count).round(2)
    end
  end

  def lowest_total_score
    min_game = @games.min_by do |game|
      game.home_goals + game.away_goals
    end
    min_game.home_goals + min_game.away_goals
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    season_name = @games.group_by {|game| game.season }
    season_name.map {|season_string, game| games_by_season[season_string] = game.count }
    games_by_season
  end

  def percentage_home_wins
    hoa = @game_teams.find_all {|gameteam| gameteam.hoa == "home" }
    results = hoa.select {|game| game.result == "WIN" }.count
    (results.to_f  / @games.count).round(2)
  end

  def percentage_visitor_wins
    hoa = @game_teams.find_all {|gameteam| gameteam.hoa == "away" }
    results = hoa.select {|game| game.result == "WIN" }.count
    (results.to_f  / @games.count).round(2)
  end

  def count_of_teams
    @teams.count
  end

  def best_offense

    team_goals = total_goals
    team_games = total_games

    averages = Hash.new(0)
    team_games.each do |team_id, game_count|
      goal_count = team_goals[team_id]
      if goal_count != nil
        averages[team_id] = goal_count / game_count.to_f
      end
    end

    highest_average_team = nil
    highest_average_score = nil
    averages.each do |id, ave|
      if highest_average_team == nil
        highest_average_team = id
        highest_average_score = ave
      end

      if ave > highest_average_score
        highest_average_team = id
        highest_average_score = ave
      end
    end

    best_average = nil
    @teams.each do |team|
      if team.team_id == highest_average_team
        best_average = team.teamname
      end
    end
    best_average
  end

  def total_goals
    team_goals = Hash.new(0)
    @games.each do |game|
      team_goals[game.home_team_id] = team_goals[game.home_team_id] + game.home_goals
      team_goals[game.away_team_id] = team_goals[game.away_team_id] + game.away_goals
    end
    team_goals
  end

  def total_games
    team_games = Hash.new(0)
    @game_teams.each do |gameteam|
      team_games[gameteam.team_id] += 1
    end
    team_games
  end

end