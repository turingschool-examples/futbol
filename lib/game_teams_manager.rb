require_relative './game_team'

class GameTeamsManager
  attr_reader :game_teams, :tracker
  def initialize(game_teams_path, tracker)
    @game_teams = []
    @tracker = tracker
    create_games(game_teams_path)
  end

  def create_games(game_teams_path)
    game_teams_data = CSV.parse(File.read(game_teams_path), headers: true)
    @game_teams = game_teams_data.map do |data|
      GameTeam.new(data, self)
    end
  end

  def games_played(team_id)
    @game_teams.find_all do |game_team|
      game_team.team_id == team_id
    end
  end

  def total_goals(team_id)
    games_played(team_id).sum do |game|
      game.goals
    end
  end

  def average_number_of_goals_scored_by_team(team_id)
    (total_goals(team_id).to_f / games_played(team_id).count).round(2)
  end

  def games_played_by_type(team_id, home_away)
    @game_teams.find_all do |game_team|
      game_team.team_id == team_id && game_team.home_away == home_away
    end
  end

  def total_goals_by_type(team_id, home_away)
    games_played_by_type(team_id, home_away).sum do |game|
      game.goals
    end
  end

  def average_number_of_goals_scored_by_team_by_type(team_id, home_away)
    (total_goals_by_type(team_id, home_away).to_f / games_played_by_type(team_id, home_away).count).round(2)
  end

  def find_season_id(game_id)
    @tracker.find_season_id(game_id)
  end

  def selected_season_game_teams(season_id)
    @game_teams.select do |game_team|
      game_team.season_id == season_id
    end
  end

  def wins_for_coach(season_id, head_coach)
    selected_season_game_teams(season_id).count do |game_team|
      game_team.result == 'WIN' if game_team.head_coach == head_coach
    end
  end

  def games_for_coach(season_id, head_coach)
    selected_season_game_teams(season_id).count do |game_team|
      game_team.head_coach == head_coach
    end
  end

  def average_win_percentage_by_season(season_id, head_coach)
    ((wins_for_coach(season_id, head_coach).to_f / games_for_coach(season_id, head_coach)) * 100).round(2)
  end

  def coaches_hash_w_avg_win_percentage(season_id)
    by_coach_wins = {}
    selected_season_game_teams(season_id).each do |game_team|
      head_coach = game_team.head_coach
      by_coach_wins[head_coach] ||= []
      by_coach_wins[head_coach] = average_win_percentage_by_season(season_id, head_coach)
    end
    by_coach_wins
  end

  def winningest_coach(season_id)
    coaches_hash_w_avg_win_percentage(season_id).max_by do |coach, avg_win_perc|
      avg_win_perc
    end.to_a[0]
  end

  def worst_coach(season_id)
    coaches_hash_w_avg_win_percentage(season_id).min_by do |coach, avg_win_perc|
      avg_win_perc
    end.to_a[0]
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

  def shot_goal_ratio(season_id, team_id)
    (goals_by_team(season_id, team_id) / shots_by_team(season_id, team_id)).round(4)
  end

  def teams_hash_w_ratio_shots_goals(season_id)
    by_team_goals_ratio = {}
    list_teams_in_season(season_id).each do |team_id|
      by_team_goals_ratio[team_id] ||= []
      by_team_goals_ratio[team_id] = shot_goal_ratio(season_id, team_id)
    end
    by_team_goals_ratio
  end

  def most_accurate_team(season_id)
    teams_hash_w_ratio_shots_goals(season_id).max_by do |team, goals_ratio|
      goals_ratio
    end.to_a[0]
  end

  def least_accurate_team(season_id)
    teams_hash_w_ratio_shots_goals(season_id).min_by do |team, goals_ratio|
      goals_ratio
    end.to_a[0]
  end

  def tackles_by_team(season_id, team_id)
    list_game_teams_season_team(season_id, team_id).sum do |game_team|
        game_team.tackles
    end
  end

  def teams_hash_w_tackles(season_id)
    tackles_by_team = {}
    list_teams_in_season(season_id).each do |team_id|
      tackles_by_team[team_id] ||= []
      tackles_by_team[team_id] = tackles_by_team(season_id, team_id)
    end
    tackles_by_team
  end

  def most_tackles(season_id)
    teams_hash_w_tackles(season_id).max_by do |team, tackles|
      tackles
    end.to_a[0]
  end

  def fewest_tackles(season_id)
    teams_hash_w_tackles(season_id).min_by do |team, tackles|
      tackles
    end.to_a[0]
  end

  def games_played_by_team_by_season(season, team_id)
    games_played(team_id).select do |game_team|
      game_team.season_id == season
    end
  end

  def total_wins_team(season, team_id)
    games_played_by_team_by_season(season, team_id).count do |game_team|
      game_team.result == 'WIN'
    end.to_f
  end

  def avg_win_pct_season(season, team_id)
    (total_wins_team(season, team_id) / games_played_by_team_by_season(season, team_id).count).round(4)
  end

  def season_win_percentage_hash(team_id)
    season_hash = {}
    games_played(team_id).each do |game_team|
      season = game_team.season_id
      season_hash[season] ||= []
      season_hash[season] = avg_win_pct_season(season, team_id)
    end
    season_hash
  end

  def get_best_season(team_id)
    season_win_percentage_hash(team_id).max_by do |season, win_percent|
      win_percent
    end.to_a[0]
  end

  def get_worst_season(team_id)
    season_win_percentage_hash(team_id).min_by do |season, win_percent|
      win_percent
    end.to_a[0]
  end

  def total_wins_team_all_seasons(team_id)
    @game_teams.count do |game_team|
      game_team.result == 'WIN' if game_team.team_id == team_id
    end
  end

  def get_average_win_percentage(team_id)
    (total_wins_team_all_seasons(team_id).to_f / games_played(team_id).count).round(2)
  end

  def get_most_goals_scored_for_team(team_id)
    games_played(team_id).max_by do |game_team|
      game_team.goals
    end.goals
  end

  def get_fewest_goals_scored_for_team(team_id)
    games_played(team_id).min_by do |game_team|
      game_team.goals
    end.goals
  end

  def game_ids_played_by_team(team_id)
    games_played(team_id).map do |game_team|
      game_team.game_id
    end
  end

  def all_teams_for_game_id_list(team_id)
    @game_teams.select do |game_team|
      game_ids_played_by_team(team_id).include?(game_team.game_id)
    end
  end

  def game_teams_played_by_opponent(team_id)
    all_teams_for_game_id_list(team_id).select do |game_team|
      game_team.team_id != team_id
    end
  end

  def games_w_opponent_hash(team_id)
    game_teams_played_by_opponent(team_id).group_by do |game_team|
      game_team.team_id
    end
  end

  def opponent_hash(team_id)
    woohoo = {}
    games_w_opponent_hash(team_id).map do |opp_team_id, game_team_obj|
      tie_loss = game_team_obj.count do |game_team|
        game_team.result == 'LOSS' || game_team.result == 'TIE'
      end
      woohoo[opp_team_id] = (tie_loss.to_f / game_team_obj.count).round(2)
    end
    woohoo
  end

  def get_favorite_opponent(team_id)
    opponent_hash(team_id).max_by do |opp_team_id, tie_loss|
      tie_loss
    end.to_a[0]
  end

  def get_rival(team_id)
    opponent_hash(team_id).min_by do |opp_team_id, tie_loss|
      tie_loss
    end.to_a[0]
  end
end
