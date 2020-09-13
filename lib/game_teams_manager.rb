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

  def coaches_records(season)
    gt_results = game_team_results_by_season(season)
    coach_record_start = initialize_coaches_records(gt_results)
    total_record = add_wins_losses(gt_results, coach_record_start)
  end

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

  def game_team_results_by_season(season)
    game_teams.find_all do |team_result|
      @tracker.find_game_ids_for_season(season).include? team_result.game_id
    end
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

  #-------------GameStatistics

  def percentage_home_wins
    average = all_home_game_wins.count / all_home_games.count.to_f
    average.round(2)
  end

  def all_home_games
    @game_teams.find_all do |game|
      game.hoa == "home"
    end
  end

  def all_home_game_wins
    all_home_games.find_all do |game|
      game.result == "WIN"
    end
  end

  def percentage_visitor_wins
    average = all_away_game_wins.count / all_away_games.count.to_f
    average.round(2)
  end

  def all_away_games
    @game_teams.find_all do |game|
      game.hoa == "away"
    end
  end

  def all_away_game_wins
    all_away_games.find_all do |game|
      game.result == "WIN"
    end
  end

  def percentage_ties
    average = all_tie_games.count / all_games.count.to_f
    average.round(2)
  end

  def all_games
    @game_teams.find_all do |game|
      game.hoa == "away" || game.hoa == "home"
    end
  end

  def all_tie_games
    all_games.find_all do |game|
      game.result == "TIE"
    end
  end

end
