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
    @game_teams.find_all do |game_team|
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

  def average_win_percentage(season_id, head_coach)
    ((wins_for_coach(season_id, head_coach).to_f / games_for_coach(season_id, head_coach)) * 100).round(2)
  end

  def coaches_hash_w_avg_win_percentage(season_id)
    by_coach_wins = {}
    selected_season_game_teams(season_id).each do |game_team|
      head_coach = game_team.head_coach
      by_coach_wins[head_coach] ||= []
      by_coach_wins[head_coach] = average_win_percentage(season_id, head_coach)
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

  def shots_by_team(season_id, team_num)
    selected_season_game_teams(season_id).sum do |game_team|
      if game_team.team_id == team_num
        game_team.shots
      else
        0
      end
    end
  end

  def goals_by_team(season_id, team_num)
    selected_season_game_teams(season_id).sum do |game_team|
      if game_team.team_id == team_num
        game_team.goals
      else
        0
      end
    end
  end

  def shot_goal_ratio(season_id, team_num)
    (goals_by_team(season_id, team_num).to_f / shots_by_team(season_id, team_num)).round(2)
  end

  def teams_hash_w_ratio_shots_goals(season_id)
    by_team_goals_ratio = {}
    selected_season_game_teams(season_id).each do |game_team|
      team_num = game_team.team_id
      by_team_goals_ratio[team_num] ||= []
      by_team_goals_ratio[team_num] = shot_goal_ratio(season_id, team_num)
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

  def tackles_by_team(season_id, team_num)
    selected_season_game_teams(season_id).sum do |game_team|
      if game_team.team_id == team_num
        game_team.tackles
      else
        0
      end
    end
  end

  def teams_hash_w_tackles(season_id)
    tackles_by_team = {}
    selected_season_game_teams(season_id).each do |game_team|
      team_num = game_team.team_id
      tackles_by_team[team_num] ||= []
      tackles_by_team[team_num] = tackles_by_team(season_id, team_num)
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
end
