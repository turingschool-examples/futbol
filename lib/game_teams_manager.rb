require_relative '../lib/findable'
class GameTeamsManager
  include Findable

  attr_reader :game_teams, :tracker

  def initialize(path, tracker)
    @game_teams = []
    @tracker = tracker
    create_game_teams(path)
  end

  def create_game_teams(path)
    game_teams_data = CSV.read(path, headers:true)
    @game_teams = game_teams_data.map do |data|
      GameTeams.new(data, self)
    end
  end

  # -------SeasonStats

  def winningest_coach(season)
    coaches_records(season).max_by do |coach, w_l|
      w_l[:wins].to_f / (w_l[:wins] + w_l[:losses] + w_l[:ties])
    end[0]
  end

  def worst_coach(season)
    coaches_records(season).min_by do |coach, w_l|
      w_l[:wins].to_f / (w_l[:wins] + w_l[:losses] + w_l[:ties])
    end[0]
  end

  def most_accurate_team(season)
    most_accurate_team_id = teams_shots_to_goals(season).max_by do |id, s_g|
      s_g[:goals].to_f / s_g[:shots]
    end[0]
    find_team_by_team_id(most_accurate_team_id)
  end

  def least_accurate_team(season)
    least_accurate_team_id = teams_shots_to_goals(season).min_by do |id, s_g|
      s_g[:goals].to_f / s_g[:shots]
    end[0]
    find_team_by_team_id(least_accurate_team_id)
  end

  def most_tackles(season)
    result_id = team_tackles(season).max_by {|id, tackle_count| tackle_count}
    find_team_by_team_id(result_id[0])
  end

  def fewest_tackles(season)
    result_id = team_tackles(season).min_by {|id, tackle_count| tackle_count}
    find_team_by_team_id(result_id[0])
  end

  def game_teams_results_by_season(season)
    game_teams.find_all do |team_result|
      @tracker.find_game_ids_for_season(season).include? team_result.game_id
    end
  end

  def coaches_records(season)
    gt_results = game_teams_results_by_season(season)
    coach_record_start = start_coaches_records(gt_results)
    add_wins_losses(gt_results, coach_record_start)
  end

  def teams_shots_to_goals(season)
    gt_results = game_teams_results_by_season(season)
    teams_shots_to_goals_start = start_shots_and_goals_per_team(gt_results)
    add_shots_and_goals(gt_results, teams_shots_to_goals_start)
  end

  def team_tackles(season)
    gt_results = game_teams_results_by_season(season)
    tackles_start = start_tackles_per_team(gt_results)
    add_tackles(gt_results, tackles_start)
  end

  def start_coaches_records(gt_results)
    coach_record_hash = {}
    gt_results.each do |team_result|
      coach_record_hash[team_result.head_coach] = {wins: 0, losses: 0, ties:0}
    end
    coach_record_hash
  end

  def add_wins_losses(gt_results, coach_record_start)
    gt_results.each do |team_result|
      if team_result.result == "WIN"
        coach_record_start[team_result.head_coach][:wins] += 1
      elsif team_result.result == "LOSS"
        coach_record_start[team_result.head_coach][:losses] += 1
      elsif team_result.result == "TIE"
        coach_record_start[team_result.head_coach][:ties] += 1
      end
    end
    coach_record_start
  end

  def start_shots_and_goals_per_team(gt_results)
    total_shots_goals = {}
    gt_results.each do |team_result|
      total_shots_goals[team_result.team_id] = {shots: 0, goals: 0}
    end
    total_shots_goals
  end

  def add_shots_and_goals(gt_results, teams_shots_to_goals_start)
    gt_results.each do |team_result|
      teams_shots_to_goals_start[team_result.team_id][:shots] += team_result.shots.to_i
      teams_shots_to_goals_start[team_result.team_id][:goals] += team_result.goals.to_i
    end
    teams_shots_to_goals_start
  end

  def start_tackles_per_team(gt_results)
    tackles_per_team = {}
    gt_results.each do |team_result|
      tackles_per_team[team_result.team_id] = 0
    end
    tackles_per_team
  end

  def add_tackles(gt_results, tackles_start)
    gt_results.each do |team_result|
      tackles_start[team_result.team_id] += team_result.tackles.to_i
    end
    tackles_start
  end
end
