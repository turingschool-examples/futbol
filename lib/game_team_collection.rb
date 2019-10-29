require 'CSV'
require_relative './game_team'

class GameTeamCollection
  attr_reader :game_teams, :game_teams_by_team_id

  def self.load_data(path)
    game_teams = {}
    game_teams_by_team_id = {}
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      game_team = GameTeam.new(row)
      if game_teams.keys.include?(row[:game_id])
        game_teams[row[:game_id]] << game_team
      else
        game_teams[row[:game_id]] = []
        game_teams[row[:game_id]] << game_team
      end

      if game_teams_by_team_id.keys.include?(row[:team_id])
        game_teams_by_team_id[row[:team_id]] << game_team
      else
        game_teams_by_team_id[row[:team_id]] = []
        game_teams_by_team_id[row[:team_id]] << game_team
      end
    end

    GameTeamCollection.new(game_teams, game_teams_by_team_id)
  end

  def initialize(game_teams, by_team)
    @game_teams = game_teams
    @game_teams_by_team_id = by_team
  end

  def most_goals
    @game_teams_by_team_id.max_by do |team_id, game_array|
      total = game_array.sum do |game|
        game.goals
      end
      (total.to_f / game_array.length).round(2)
    end[0]
  end

  def most_visitor_goals
    away_games.max_by do |team_id, away_game_array|
      if away_game_array.length != 0
      total = away_game_array.sum do |away_game|
        away_game.goals
      end
      (total.to_f / away_game_array.length).round(2)
      else 0
      end
    end[0]
  end

  def most_home_goals
    home_games.max_by do |team_id, home_game_array|
      if home_game_array.length != 0
      total = home_game_array.sum do |home_game|
        home_game.goals
      end
      (total.to_f / home_game_array.length).round(2)
      else 0
      end
    end[0]
  end

  def away_games
    away_games = {}
    @game_teams_by_team_id.each do |team_id, game_array|
      away_games[team_id] = game_array.find_all do |game|
        game.hoa == "away"
      end
    end
    away_games
  end

  def home_games
    home_games = {}
    @game_teams_by_team_id.each do |team_id, game_array|
      home_games[team_id] = game_array.find_all do |game|
        game.hoa == "home"
      end
    end
    home_games
  end

  def lowest_visitor_goals
    away_games.min_by do |team_id, away_game_array|
      if away_game_array.length != 0
      total = away_game_array.sum do |away_game|
        away_game.goals
      end
      (total.to_f / away_game_array.length).round(2)
      else 0
      end
    end[0]
  end

  def lowest_home_goals
    home_games.min_by do |team_id, home_game_array|
      if home_game_array.length != 0
      total = home_game_array.sum do |home_game|
        home_game.goals
      end
      (total.to_f / home_game_array.length).round(2)
      else 0
      end
    end[0]
  end







end
