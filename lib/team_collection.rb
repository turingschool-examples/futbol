require 'csv'
require_relative './team.rb'
require_relative './game_team.rb'
# require_relative './game_collection'


class TeamCollection
  attr_reader :total_teams, :total_games

  def initialize(team_path, game_team_path)
    @total_games = create_game_team(game_team_path)
    @total_teams = create_teams(team_path)
  end

  def create_game_team(game_team_path)
    csv = CSV.read(game_team_path, headers: true, header_converters: :symbol)
    csv.map do |row|
      GameTeam.new(row)
    end
  end

  def create_teams(team_path)
    csv = CSV.read(team_path, headers: true, header_converters: :symbol)

    csv.map do |team|
      all_game_ids = []
      all_team_games = @total_games.find_all do |game_team|
        if team[:team_id] == game_team.team_id
          all_game_ids << game_team.game_id
        end
      end
      all_opponent_games = all_game_ids.flat_map do |game_id|
        @total_games.find_all do |game_team|
          game_team.game_id == game_id && game_team.team_id != team[:team_id]
        end
      end
      # all_opponent_games = @total_games.find_all do |game|
      #   team[:team_id] == game.team_id
      # end
      Team.new(team, all_team_games, all_opponent_games)
    end
  end

  def count_of_teams
    @total_teams.length
  end

  def best_offense
    @total_teams.max_by do |team|
      team.average_goals_scored_per_game
    end.team_name
  end

  def worst_offense
    @total_teams.min_by do |team|
      team.average_goals_scored_per_game
    end.team_name
  end

  def best_defense
    @total_teams.min_by do |team|
      team.average_goals_allowed_per_game
    end.team_name
  end

  def worst_defense
    @total_teams.max_by do |team|
      team.average_goals_allowed_per_game
    end.team_name
  end

  def winningest_team
    @total_teams.max_by do |team|
      team.win_percentage
    end.team_name
  end

  def best_fans
    @total_teams.max_by do |team|
      team.home_win_percentage - team.away_win_percentage
    end.team_name
  end

  def worst_fans
    worst_fans_list = @total_teams.find_all do |team|
      team.away_win_percentage > team.home_win_percentage
    end
    worst_fans_list.map do |team|
      team.team_name
    end
  end

  def highest_scoring_visitor
    highest_away_team = @total_teams.max_by do |team|
      team.away_game_goals / team.away_games_by_team.count.to_f
    end
    highest_away_team.team_name
  end

  def highest_scoring_home_team
    highest_home_team = @total_teams.max_by do |team|
      team.home_game_goals / team.home_games_by_team.count.to_f
    end
    highest_home_team.team_name
  end

  def lowest_scoring_visitor
    lowest_scoring_away_team = @total_teams.min_by do |team|
      team.away_game_goals / team.away_games_by_team.count.to_f
    end
    lowest_scoring_away_team.team_name
  end

  def lowest_scoring_home_team
    lowest_scoring_home = @total_teams.min_by do |team|
      team.home_game_goals / team.home_games_by_team.count.to_f
    end
    lowest_scoring_home.team_name
  end

  def team_info(team_id)
    team_information = {}
    @total_teams.map do |team|
      team_id == team.team_id
      team_information[:team_id] = team.team_id
      team_information[:franchise_id] = team.franchise_id
      team_information[:team_name] = team.team_name
      team_information[:abbreviation] = team.abbreviation
      team_information[:link] = team.link
    end
    team_information
  end

  def all_team_games(team_id)
    all_games = @total_games.count { |game| game.team_id == team_id }
  end

  def all_won_games(team_id)
    wins = @total_games.count { |game| game.result == "WIN" && game.team_id == team_id }
  end

  def average_win_percentage(team_id)
    avg_win_percentage = (all_won_games(team_id).to_f / all_team_games(team_id)*100).round(2)
  end

  def best_season(team_id)
    # group games by season (game_collection)
    # number of wins in season / number of games in season
    # return the string of season name
  end
end
