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

  def fewest_goals
    @game_teams_by_team_id.min_by do |team_id, game_array|
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

  def team_highest_win_percent
    @game_teams_by_team_id.max_by do |team_id, game_array|
      (games_won(game_array) / game_array.length.to_f).round(2)
    end[0]
  end

  def games_won(games)
    games.count do |game|
      game.result == "WIN"
    end
  end

  # def fewest_allowed_goals
  #   @game_teams_by_team_id.map do |team_id, game_array|
  #     away_games = game_array.find_all do |game_team|
  #       game_team.hoa == "away"
  #     end
  #     fewest_goals = away_games.sum do |game|
  #       game.goals
  #     end
  #
  #     if away_games.length > 0
  #       f = fewest_goals.to_f / away_games.length
  #     elsif away_games.length == 0
  #       0
  #     end
  #
  #     key = away_games.map do |game_team|
  #       game_team.team_id
  #     end
  #
  #     away_avg = away_games.reduce({}) do |min_goals, game_team|
  #       min_goals[key.flatten] = f
  #       min_goals
  #     end
  #
  #     away_avg.min_by do |team_id, avg_goals_scored|
  #       avg_goals_scored
  #     end
  #   end
  # end

  def team_with_best_fans
    @game_teams_by_team_id.max_by do |team_id, game_array|

      home_wins = game_array.count do |game_team|
        game_team.result == "WIN" && game_team.hoa == "home"
      end

      away_wins = game_array.count do |game_team|
        game_team.result == "WIN" && game_team.hoa == "away"
      end

      home = (home_wins.to_f / game_array.length).round(2)
      away = (away_wins.to_f / game_array.length).round(2)
      (home - away).abs.round(2)
    end[0]
  end

  def team_with_worst_fans
    more_away_wins = @game_teams_by_team_id.values.find_all do |game_array|

      home_wins = game_array.count do |game_team|
        game_team.result == "WIN" && game_team.hoa == "home"
      end

      away_wins = game_array.count do |game_team|
        game_team.result == "WIN" && game_team.hoa == "away"
      end

      away_wins > home_wins

    end.flatten

    more_away_wins.map do |game_team|
      game_team.team_id
    end.uniq
  end
end
