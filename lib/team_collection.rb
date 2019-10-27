require 'csv'
require_relative './team.rb'
require_relative './game_team.rb'
# require_relative './game_collection'

class TeamCollection
  attr_reader :total_teams

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

  def group_by_away_team_id_and_goals
    away_team_groups = @all_team_games.map { |team| team.team_id}
    away_team_goals = @all_team_games.flat_map { |team| team.goals}
    away_team_id_goals = away_team_groups.zip(away_team_goals)
    require "pry"; binding.pry
  end

  def highest_scoring_visitor
    highest_away_team_name = @total_teams.find do |team|
       @game_collection.highest_average_away_goals == team.team_id.to_i
     end
    highest_away_team_name.team_name
  end

  def highest_scoring_home_team
    highest_home_team_name = @total_teams.find do |team|
      @game_collection.highest_average_home_goals == team.team_id.to_i
    end
    highest_home_team_name.team_name
  end

  def lowest_scoring_away_team
    lowest_away_team_name = @total_teams.find do |team|
      @game_collection.lowest_average_away_goals == team.team_id.to_i
    end
    lowest_average_away_goals.team_name
  end

  def lowest_scoring_home_team
    lowest_home_team_name = @total_teams.find do |team|
      @game_collection.lowest_average_home_goals == team.team_id.to_i
    end
    lowest_average_home_goals.team_name
  end
end
