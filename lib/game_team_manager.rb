require 'csv'
require_relative './mathable'


class GameTeamManager
  include Mathable
  attr_reader :game_teams,
              :tracker
  def initialize(path, tracker)
    @game_teams = []
    create_underscore_game_teams(path)
    @tracker = tracker
  end

  def create_underscore_game_teams(path)
    game_teams_data = CSV.read(path, headers: true)
    @game_teams = game_teams_data.map do |data|
      GameTeam.new(data, self)
    end
  end

  def average_win_percentage(team_id)
    team_game_count = Hash.new(0)
    team_wins = Hash.new(0)
    @game_teams.each do |game|
      if game.team_id == team_id
        team_game_count[game.team_id] += 1
        if game.result == "WIN"
          team_wins[game.team_id] += 1
        end
      end
    end
    (team_wins[team_id].to_f / team_game_count[team_id]).round(2)
  end

  def best_offense
    team_goals = Hash.new(0)
    team_game_count = Hash.new(0)
    @game_teams.each do |game_team|
      team_goals[game_team.team_id] += game_team.goals
      team_game_count[game_team.team_id] += 1
    end
    best_offense = sort_percentages(team_goals, team_game_count)
    @tracker.get_team_name(best_offense.last[0])
  end

  def worst_offense
    team_goals = Hash.new(0)
    team_game_count = Hash.new(0)
    @game_teams.each do |game_team|
      team_goals[game_team.team_id] += game_team.goals
      team_game_count[game_team.team_id] += 1
    end
    worst_offense = sort_percentages(team_goals, team_game_count)
    @tracker.get_team_name(worst_offense.first[0])
  end

  def most_accurate_team(season)
    game_ids = @tracker.get_season_game_ids(season)
    total_shots_by_team = Hash.new(0.0)
    total_goals_by_team = Hash.new(0.0)
    @game_teams.each do |game|
      if game_ids.include?(game.game_id)
        total_shots_by_team[game.team_id] += game.shots.to_f
        total_goals_by_team[game.team_id] += game.goals.to_f
      end
    end
    most_accurate_team = sort_percentages(total_goals_by_team, total_shots_by_team)
    @tracker.get_team_name(most_accurate_team.last[0])
  end

  def least_accurate_team(season)
    game_ids = @tracker.get_season_game_ids(season)
    total_shots_by_team = Hash.new(0.0)
    total_goals_by_team = Hash.new(0.0)
    @game_teams.each do |game|
      if game_ids.include?(game.game_id)
        total_shots_by_team[game.team_id] += game.shots.to_f
        total_goals_by_team[game.team_id] += game.goals.to_f
      end
    end
    least_accurate_team = sort_percentages(total_goals_by_team, total_shots_by_team)
    @tracker.get_team_name(least_accurate_team.first[0])
  end

  def most_tackles(season)
    game_ids = @tracker.get_season_game_ids(season)
    team_tackles = Hash.new(0)
    @game_teams.each do |game|
      if game_ids.include?(game.game_id)
        team_tackles[game.team_id] += game.tackles.to_i
      end
    end
    most_tackles_team = team_tackles.max_by do |team, tackles|
      tackles
    end[0]
    @tracker.get_team_name(most_tackles_team)
  end

  def fewest_tackles(season)
    game_ids = @tracker.get_season_game_ids(season)
    team_tackles = Hash.new(0)
    @game_teams.each do |game|
      if game_ids.include?(game.game_id)
        team_tackles[game.team_id] += game.tackles.to_i
      end
    end
    most_tackles_team = team_tackles.min_by do |team, tackles|
      tackles
    end[0]
    @tracker.get_team_name(most_tackles_team)
  end

  def find_winningest_coach(game_ids, expected_result)
    coach_game_count = Hash.new(0)
    coach_wins = Hash.new(0.0)
    @game_teams.each do |game|
      if game_ids.include?(game.game_id)
        coach_game_count[game.head_coach] += 1
        if game.result == expected_result
          coach_wins[game.head_coach] += 1
        end
      end
    end
    sort_percentages(coach_wins, coach_game_count).last[0]
  end

  def find_worst_coach(game_ids)
    coach_game_count = Hash.new(0)
    coach_losses = Hash.new(0.0)
    @game_teams.each do |game|
      if game_ids.include?(game.game_id)
        coach_game_count[game.head_coach] += 1
        if game.result == "LOSS" || game.result == "TIE"
          coach_losses[game.head_coach] += 1
        end
      end
    end
    sort_percentages(coach_losses, coach_game_count).last[0]
  end

  def find_all_games(team_id)
    @game_teams.find_all do |game|
      game.team_id == team_id
    end
  end

  def most_goals_scored(team_id)
    high_goals = find_all_games(team_id).max_by do |game|
      game.goals
    end
    high_goals.goals
  end

  def fewest_goals_scored(team_id)
    low_goals = find_all_games(team_id).min_by do |game|
      game.goals
    end
    low_goals.goals
  end

  def find_game_ids(team_id)
    find_all_games(team_id).map do |game|
      game.game_id
    end
  end

  def favorite_opponent(team_id)
    total_games = Hash.new(0)
    loser_loses = Hash.new(0)
    game_id_array = find_game_ids(team_id)
    @game_teams.each do |game|
      if game_id_array.include?(game.game_id) && game.team_id != team_id
        total_games[game.team_id] += 1
        if game.result == "LOSS"
          loser_loses[game.team_id] += 1
        end
      end
    end
    biggest_loser = sort_percentages(loser_loses, total_games)
    @tracker.get_team_name(biggest_loser.last[0])
  end

  def rival(team_id)
    total_games = Hash.new(0)
    winner_wins = Hash.new(0)
    game_id_array = find_game_ids(team_id)
    @game_teams.each do |game|
      if game_id_array.include?(game.game_id) && game.team_id !=team_id
        total_games[game.team_id] += 1
        if game.result == "WIN"
          winner_wins[game.team_id] += 1
        end
      end
    end
    biggest_winner = sort_percentages(winner_wins, total_games)
    @tracker.get_team_name(biggest_winner.last[0])
  end
end
