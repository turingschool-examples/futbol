class GameTeamsManager
  attr_reader :game_teams, :tracker #do we need attr_reader?
  def initialize(path, tracker)
    @game_teams = []
    @tracker = tracker
    create_game_teams(path)
  end

  def create_game_teams(path)
    game_teams_data = CSV.read(path, headers:true) #may need to change .read to .load
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



  def game_teams_results_by_season(season)
    game_teams.find_all do |team_result|
      @tracker.find_game_ids_for_season(season).include? team_result.game_id
    end
  end

  def coaches_records(season)
    gt_results = game_teams_results_by_season(season)
    coach_record_start = initialize_coaches_records(gt_results)
    total_record = add_wins_losses(gt_results, coach_record_start)
  end

  def initialize_coaches_records(gt_results)
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

  def initialize_shots_and_goals_per_team(gt_results)
    total_shots_goals = {}
    gt_results.each do |team_result|
      total_shots_goals[team_result['team_id']] = {shots: 0, goals: 0}
    end
    total_shots_goals
  end
end
