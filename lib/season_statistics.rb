require 'csv'
require_relative './game_team'
require_relative './game'
require_relative './team'

class SeasonStatistics
  attr_reader :games,
              :game_teams,
              :teams

  def initialize(games, game_teams,teams)
    @games = games
    @game_teams = game_teams
    @teams = teams
  end

  def self.from_csv(games_filepath, game_teams_filepath, teams_filepath)
    game_teams = []

    CSV.foreach(game_teams_filepath, headers: true, header_converters: :symbol) do |row|
      game_teams << GameTeam.new(row)
    end

    games = []

    CSV.foreach(games_filepath, headers: true, header_converters: :symbol) do |row|
      games << Game.new(row)
    end

    teams = []

    CSV.foreach(teams_filepath, headers: true, header_converters: :symbol) do |row|
      teams << Team.new(row)

    end

    new(games, game_teams, teams)
  end

  def worst_coach(season)
      coach_average_win_pct = calculate_win_percentage(season)
      worst_coach_name = coach_average_win_pct.min_by { |_, average_win_pct|average_win_pct }.first

      worst_coach_name
  end

  def winningest_coach(season)
    coach_average_win_pct = calculate_win_percentage(season)
    winningest_coach = coach_average_win_pct.max_by { |_, average_win_pct|average_win_pct }.first

    winningest_coach
  end

  def calculate_win_percentage(season)
    season_game_ids = games
      .find_all { |game| game.season == season }
      .map{ |game| game.game_id }

    coach_games = game_teams
      .find_all { |game_team| season_game_ids.include?(game_team.game_id) }
      .group_by { |game_team|game_team.head_coach }

    coach_average_win_pct = {}
    coach_games.each do |coach, game_teams|
      total_games = game_teams.length
      total_winning_games = game_teams.count {|game_team| game_team.result == "WIN"}
      if total_games > 0
        coach_average_win_pct[coach] = ((total_winning_games/total_games).to_f * 100).round(2)
      else
        coach_average_win_pct[coach] = 0.0
      end
    end

    coach_average_win_pct
  end

  def calculate_accurate_shots_pct(season)
    season_game_ids = games
      .find_all { |game| game.season == season }
      .map{ |game| game.game_id }

    team_games = game_teams
      .find_all { |game_team| season_game_ids.include?(game_team.game_id) }
      .group_by { |game_team|game_team.team_id }

    accurate_shots_pct_by_team = {}
    team_games.each do |team_id, game_teams|
      total_goals = game_teams.sum { |game_team| game_team.goals }
      total_shots = game_teams.sum { |game_team| game_team.shots }
      if total_shots > 0
        accurate_shots_pct_by_team[team_id] = ((total_goals.to_f/total_shots) * 100).round(2)
      else
        accurate_shots_pct_by_team[team_id] = 0.0
      end
    end
    accurate_shots_pct_by_team
  end

  def most_accurate_team(season)
    team_accurate_shots_pct = calculate_accurate_shots_pct(season)
    most_accurate_team_id = team_accurate_shots_pct.max_by { |_,accurate_shots_pct| accurate_shots_pct }.first
    most_accurate_team = teams.find { |team| team.team_id == most_accurate_team_id }
    most_accurate_team.teamname
  end

  def least_accurate_team(season)
    team_accurate_shots_pct = calculate_accurate_shots_pct(season)
    least_accurate_team_id = team_accurate_shots_pct.min_by { |_,accurate_shots_pct| accurate_shots_pct }.first
    least_accurate_team = teams.find { |team| team.team_id == least_accurate_team_id }
    least_accurate_team.teamname
  end

  def tackles_by_teams(season)
    season_game_ids = games
      .find_all { |game| game.season == season }
      .map{ |game| game.game_id }

    team_games = game_teams
      .find_all { |game_team| season_game_ids.include?(game_team.game_id) }
      .group_by { |game_team|game_team.team_id }

    tackles_by_team_id = {}
    team_games.each do |team_id, game_teams|
      total_tackles = game_teams.sum { |game_team| game_team.tackles }
      tackles_by_team_id[team_id] = total_tackles
    end
    tackles_by_team_id
  end

  def most_tackles(season)
    tackles_by_team_id = tackles_by_teams(season)
    most_tackles_team_id = tackles_by_team_id.max_by { |_,tackles| tackles }.first
    most_tackles_team = teams.find { |team| team.team_id == most_tackles_team_id }
    most_tackles_team.teamname
  end

  def fewest_tackles(season)
    tackles_by_team_id = tackles_by_teams(season)
    fewest_tackles_team_id = tackles_by_team_id.min_by { |_,tackles| tackles }.first
    fewest_tackles_team = teams.find { |team| team.team_id == fewest_tackles_team_id }
    fewest_tackles_team.teamname
  end
end
