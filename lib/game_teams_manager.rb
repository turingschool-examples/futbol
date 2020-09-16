require_relative './game_team'
require_relative './game_teams_helper'
require_relative './averageable'

class GameTeamsManager
  include Averageable
  attr_reader :game_teams, :tracker
  def initialize(game_teams_path, tracker)
    @game_teams = []
    @tracker = tracker
    create_games(game_teams_path)
    create_helper
  end

  def create_games(game_teams_path)
    game_teams_data = CSV.parse(File.read(game_teams_path), headers: true)
    @game_teams = game_teams_data.map do |data|
      GameTeam.new(data, self)
    end
  end

  def create_helper
    @helper = GameTeamsHelper.new(self)
  end

  def find_season_id(game_id)
    @tracker.find_season_id(game_id)
  end

  # Datasets
  def games_played(team_id)
    @game_teams.select do |game_team|
      game_team.team_id == team_id
    end
  end

  def games_played_by_type(team_id, home_away)
    @game_teams.select do |game_team|
      game_team.team_id == team_id && game_team.home_away == home_away
    end
  end

  def selected_season_game_teams(season_id)
    @game_teams.select do |game_team|
      game_team.season_id == season_id
    end
  end

  def all_teams_for_game_id_list(team_id)
    @game_teams.select do |game_team|
      game_ids_played_by_team(team_id).include?(game_team.game_id)
    end
  end

  def coaches_hash_avg_win_pct(season_id)
    by_coach_wins = {}
    selected_season_game_teams(season_id).each do |game_team|
      head_coach = game_team.head_coach
      by_coach_wins[head_coach] ||= []
      by_coach_wins[head_coach] = average(wins_for_coach(season_id, head_coach), games_for_coach(season_id, head_coach), 2)
    end
    by_coach_wins
  end

  def list_teams_in_season(season_id)
    selected_season_game_teams(season_id).map do |game_team|
      game_team.team_id
    end.uniq
  end

  def list_game_teams_season_team(season_id, team_id)
    selected_season_game_teams(season_id).select do |game_team|
      game_team.team_id == team_id
    end
  end

  def teams_hash_shots_goals(season_id)
    by_team_goals_ratio = {}
    list_teams_in_season(season_id).each do |team_id|
      by_team_goals_ratio[team_id] ||= []
      by_team_goals_ratio[team_id] = average(goals_by_team(season_id, team_id), shots_by_team(season_id, team_id))
    end
    by_team_goals_ratio
  end

  def teams_hash_w_tackles(season_id)
    tackles_by_team = {}
    list_teams_in_season(season_id).each do |team_id|
      tackles_by_team[team_id] ||= []
      tackles_by_team[team_id] = tackles_by_team(season_id, team_id)
    end
    tackles_by_team
  end

  def games_played_by_team_by_season(season, team_id)
    games_played(team_id).select do |game_team|
      game_team.season_id == season
    end
  end

  def season_win_pct_hash(team_id)
    season_hash = {}
    games_played(team_id).each do |game_team|
      season = game_team.season_id
      season_hash[season] ||= []
      season_hash[season] = average_with_count(total_wins_team(season, team_id), games_played_by_team_by_season(season, team_id))
    end
    season_hash
  end

  def game_ids_played_by_team(team_id)
    games_played(team_id).map do |game_team|
      game_team.game_id
    end
  end

  def game_teams_played_by_opponent(team_id)
    all_teams_for_game_id_list(team_id).select do |game_team|
      game_team.team_id != team_id
    end
  end

  def opponent_hash(team_id)
    woohoo = {}
    games_w_opponent_hash(team_id).map do |opp_team_id, game_team_obj|
      tie_loss = game_team_obj.count do |game_team|
        game_team.result == 'LOSS' || game_team.result == 'TIE'
      end.to_f
      woohoo[opp_team_id] = average_with_count(tie_loss, game_team_obj, 2)
    end
    woohoo
  end

  # Helpers
  # def total_goals(team_id)
  #   games_played(team_id).sum do |game|
  #     game.goals
  #   end.to_f
  # end

  def average_number_of_goals_scored_by_team(team_id)
    average_with_count(@helper.total_goals(team_id), games_played(team_id), 2)
  end

  def total_goals_by_type(team_id, home_away)
    games_played_by_type(team_id, home_away).sum do |game|
      game.goals
    end.to_f
  end

  def average_number_of_goals_scored_by_team_by_type(team_id, home_away)
    average_with_count(total_goals_by_type(team_id, home_away), games_played_by_type(team_id, home_away), 2)
  end

  def wins_for_coach(season_id, head_coach)
    selected_season_game_teams(season_id).count do |game_team|
      game_team.result == 'WIN' if game_team.head_coach == head_coach
    end.to_f
  end

  def games_for_coach(season_id, head_coach)
    selected_season_game_teams(season_id).count do |game_team|
      game_team.head_coach == head_coach
    end
  end

  def shots_by_team(season_id, team_id)
    list_game_teams_season_team(season_id, team_id).sum do |game_team|
      game_team.shots
    end
  end

  def goals_by_team(season_id, team_id)
    list_game_teams_season_team(season_id, team_id).sum do |game_team|
      game_team.goals
    end.to_f
  end

  def tackles_by_team(season_id, team_id)
    list_game_teams_season_team(season_id, team_id).sum do |game_team|
      game_team.tackles
    end
  end

  def total_wins_team(season, team_id)
    games_played_by_team_by_season(season, team_id).count do |game_team|
      game_team.result == 'WIN'
    end.to_f
  end

  def total_wins_team_all_seasons(team_id)
    @game_teams.count do |game_team|
      game_team.result == 'WIN' if game_team.team_id == team_id
    end.to_f
  end

  def get_average_win_pct(team_id)
    average_with_count(total_wins_team_all_seasons(team_id), games_played(team_id), 2)
  end

  def games_w_opponent_hash(team_id)
    game_teams_played_by_opponent(team_id).group_by do |game_team|
      game_team.team_id
    end
  end

  # Core Statistics
  def winningest_coach(season_id)
    coaches_hash_avg_win_pct(season_id).max_by { |coach, avg_win| avg_win }.to_a[0]
  end

  def worst_coach(season_id)
    coaches_hash_avg_win_pct(season_id).min_by { |coach, avg_win| avg_win }.to_a[0]
  end

  def most_accurate_team(season_id)
    teams_hash_shots_goals(season_id).max_by { |team, goals_ratio| goals_ratio }.to_a[0]
  end

  def least_accurate_team(season_id)
    teams_hash_shots_goals(season_id).min_by { |team, goals_ratio| goals_ratio }.to_a[0]
  end

  def most_tackles(season_id)
    teams_hash_w_tackles(season_id).max_by { |team, tackles| tackles }.to_a[0]
  end

  def fewest_tackles(season_id)
    teams_hash_w_tackles(season_id).min_by { |team, tackles| tackles }.to_a[0]
  end

  def get_best_season(team_id)
    season_win_pct_hash(team_id).max_by { |season, win_pct| win_pct }.to_a[0]
  end

  def get_worst_season(team_id)
    season_win_pct_hash(team_id).min_by { |season, win_pct| win_pct }.to_a[0]
  end

  def get_most_goals_scored_for_team(team_id)
    games_played(team_id).max_by { |game_team| game_team.goals }.goals
  end

  def get_fewest_goals_scored_for_team(team_id)
    games_played(team_id).min_by { |game_team| game_team.goals }.goals
  end

  def get_favorite_opponent(team_id)
    opponent_hash(team_id).max_by { |opp_team_id, tie_loss| tie_loss }.to_a[0]
  end

  def get_rival(team_id)
    opponent_hash(team_id).min_by { |opp_team_id, tie_loss| tie_loss }.to_a[0]
  end
end
