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
    gt_results = game_team_results_by_season(season)
    coach_record_start = initialize_coaches_records(gt_results)
    total_record = add_wins_losses(gt_results, coach_record_start)
    determine_winningest_coach(total_record)
  end

  def game_team_results_by_season(season)
    game_teams.find_all do |team_result|
      @tracker.find_game_ids_for_season(season).include? team_result.game_id
    end
  end
end
