require "CSV"
require "./lib/games"
require "./lib/game_teams"

class StatTracker
  attr_reader :games, :game_teams, :teams

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @games ||= turn_games_csv_data_into_games_objects(locations[:games])
    @teams ||= turn_teams_csv_data_into_teams_objects(locations[:teams])
    @game_teams ||= turn_game_teams_csv_data_into_game_teams_objects(locations[:game_teams])
  end

  def turn_games_csv_data_into_games_objects(games_csv_data)
    games_objects_collection = []
    CSV.foreach(games_csv_data, headers: true, header_converters: :symbol) do |row|
      games_objects_collection << Games.new(row)
    end
    games_objects_collection
  end

  def turn_teams_csv_data_into_teams_objects(teams_csv_data)
    teams_objects_collection = []
    CSV.foreach(teams_csv_data, headers: true, header_converters: :symbol) do |row|
      teams_objects_collection << Teams.new(row)
    end
    teams_objects_collection
  end

  def turn_game_teams_csv_data_into_game_teams_objects(game_teams_csv_data)
    game_teams_objects_collection = []
    CSV.foreach(game_teams_csv_data, headers: true, header_converters: :symbol) do |row|
      game_teams_objects_collection << GameTeams.new(row)
    end
    game_teams_objects_collection
  end

  def highest_total_score
    output = @games.max_by do |game|
      game.total_game_score
    end
    output.total_game_score
  end

  def total_number_games_across_seasons
    @games.count
  end


  def highest_scoring_visitor

    visiting_teams = {}
    @games.each do |game|
      visiting_teams[game.game_id] = game.away_team_id
    end

    away_goals = Hash.new{0}
    @games.sum do |game|
      away_goals[game.away_team_id] += game.away_goals
    end

    games_by_team_id = @games.reduce(Hash.new { |h,k| h[k]=[] }) do |result, game|
        result[game.away_team_id] << game.game_id
      result
    end

    games_count_by_team_id = {}
    games_by_team_id.each do |team_id, games_array|
      games_count_by_team_id[team_id] = games_array.count
    end

    highest_away_team = games_count_by_team_id.max_by do |team_id, game_count|
      game_count
    end

    @teams.find do |team|
      team.team_id == highest_away_team[0]
    end.teamname
  end
  
end
