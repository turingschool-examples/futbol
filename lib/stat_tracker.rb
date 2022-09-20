require 'csv'
require_relative 'stat_helper'
require_relative 'team_statistics'
require_relative 'league_statistics'
require_relative 'season_statistics'
require_relative 'game_statistics'

class StatTracker < StatHelper
  include GameStatistics
  include TeamStatistics
  include LeagueStatistics
  include SeasonStatistics
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(csv_hash)
    games_input = CSV.read(csv_hash[:games], headers: true, header_converters: :symbol)
    teams_input = CSV.read(csv_hash[:teams], headers: true, header_converters: :symbol)
    game_teams_input = CSV.read(csv_hash[:game_teams], headers: true, header_converters: :symbol)
    stats_tracker = StatTracker.new(games_input, teams_input, game_teams_input)
  end
#------------------------------------Game Statistics------------------------------------
  def total_goals_per_season
    goals_per_season = Hash.new(0.0)
    @games.each do |game|
      goals_per_season[game[:season]] += game[:away_goals].to_f + game[:home_goals].to_f
    end
    goals_per_season
  end
#-----------------------------------League Statistics-----------------------------------
  def avg_goals_per_game
    hash = {}
    @game_teams.each do |row|
      if hash[row[:team_id]] == nil
        hash[row[:team_id]] = {games: 1, goals: row[:goals].to_i}
      else
        hash[row[:team_id]][:games] += 1
        hash[row[:team_id]][:goals] += row[:goals].to_i
      end
    end
    avg_goals_per_game = hash.map do |team_id, games_goals_hash|
      [team_id, (games_goals_hash[:goals].to_f/games_goals_hash[:games])]
    end
    avg_goals_per_game
  end

  def away_games_by_team_id
    away_games_list = @game_teams.find_all {|game| game[:hoa] == "away"}
    away_games_hash = Hash.new([])
    away_games_list.each do |game|
      away_games_hash[game[:team_id].to_i] += [game]
    end
    away_games_hash
  end

  def home_games_by_team_id
    home_games_list = @game_teams.find_all {|game| game[:hoa] == "home"}
    home_games_hash = Hash.new([])
    home_games_list.each do |game|
      home_games_hash[game[:team_id].to_i] += [game]
    end
    home_games_hash
  end

  def average_scores_for_all_visitors
    @visitor_hash = {}
    away_games_by_team_id.each do |team_id, games_array|
      @visitor_hash[team_id] = average_score_per_game(games_array)
    end
    @visitor_hash
  end

  def average_scores_for_all_home_teams
    @home_hash = {}
    home_games_by_team_id.each do |team_id, games_array|
      @home_hash[team_id] = average_score_per_game(games_array)
    end
    @home_hash
  end
#-----------------------------------Season Statistics-----------------------------------
  def season_game_teams(season)
    season_game_teams = @game_teams.find_all {|row| row[:game_id].start_with?(season[0..3])}
  end

  def game_wins_by_season(season)
    games_by_season
    game_id_by_season = @games_by_season_hash[season]
    @wins_by_season = @game_teams.find_all {|game| game[:result] == "WIN" && game_id_by_season.include?(game[:game_id])}
  end

  def total_games_by_coaches_by_season(season)
    games_by_season
    game_id_by_season = @games_by_season_hash[season]
    @games_by_coaches_by_season = Hash.new([])
    @game_teams.each do |game|
      if game_id_by_season.include?(game[:game_id])
        @games_by_coaches_by_season[game[:head_coach]] += [game]
      end
    end
  end

  def coach_stats_by_season(season)
    game_wins_by_season(season)
    total_games_by_coaches_by_season(season)
    @coaches_wins_to_losses = Hash.new
    @games_by_coaches_by_season.each do |coach, game|
      @coaches_wins_to_losses[coach] = (@wins_by_season.count {|game| game[:head_coach] == coach }.to_f / @games_by_coaches_by_season[coach].length).round(2)
    end
  end

  def season_shots_to_goals(season)
    season_game_teams = season_game_teams(season)
    shots_to_goals = Hash.new(0)
    season_shots = Hash.new(0)
    season_goals = Hash.new(0)
    season_game_teams.each { |row| season_goals[row[:team_id]] += row[:goals].to_f }
    season_game_teams.each { |row| season_shots[row[:team_id]] += row[:shots].to_f }
    season_shots.keys.each {|team_id| shots_to_goals[team_id] = season_shots[team_id]/season_goals[team_id]}
    shots_to_goals
  end

  def games_by_season
    @games_by_season_hash = Hash.new([])
    @games.each do |game|
      @games_by_season_hash[game[:season]] += [game[:game_id]]
    end
    @games_by_season_hash
  end

  def tackles_by_team(season)
    games_by_season
    games_in_select_season = @games_by_season_hash[season]
    @tackles_counter = Hash.new(0)
    @game_teams.each do |game|
      if games_in_select_season.include?(game[:game_id])
        @tackles_counter[game[:team_id]] += game[:tackles].to_i
      end
    end
    @tackles_counter
  end
#------------------------------------Team Statistics------------------------------------
  def games_by_team_by_season(team_id)
    games_by_season
    @games_by_team_by_season_hash = Hash.new([])
    @games_by_season_hash.each do |season, games_array|
      @games_by_team_by_season_hash[season] += @game_teams.find_all {|game| team_id == game[:team_id] && games_array.include?(game[:game_id])}
    end
    @games_by_team_by_season_hash
  end

  def games_by_team
    @games_by_team_hash = Hash.new([])
    @game_teams.each do |game|
      @games_by_team_hash[game[:team_id]] += [game]
    end
    @games_by_team_hash
  end

  def team_games_opponents(team_id)
    team_games_opponents = {}
    @games.each do |game|
      if game[:away_team_id] == team_id
        team_games_opponents[game[:game_id]] = game[:home_team_id]
      elsif game[:home_team_id] == team_id
        team_games_opponents[game[:game_id]] = game[:away_team_id]
      end
    end
    team_games_opponents
  end

  def opponent_win_loss(team_id)
    team_games_opponents = team_games_opponents(team_id)
    opponent_win_loss = {}
    team_games_opponents.values.uniq.each do |opponent_id|
      opponent_win_loss[opponent_id] = [0,0]
    end

    @game_teams.each do |game|
      if team_games_opponents.keys.include?(game[:game_id]) && team_games_opponents.values.include?(game[:team_id])
        if game[:result] == "WIN"
          opponent_win_loss[game[:team_id]][0] += 1
        elsif game[:result] =="LOSS"
          opponent_win_loss[game[:team_id]][1] += 1
        end
      end
    end
    opponent_win_loss
  end
end