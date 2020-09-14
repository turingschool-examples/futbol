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

#-------------TeamStats
  def best_season(team_id)
    best_season = win_percentage_by_season(team_id).max_by do |season, wins_percent|
        wins_percent
      end
      best_year = best_season[0].to_i
      "#{best_year}201#{best_year.digits[0] + 1}"
    end

  def worst_season(team_id)
    worst_season = win_percentage_by_season(team_id).min_by do |season, wins_percent|
        wins_percent
      end
      worst_year = worst_season[0].to_i
      "#{worst_year}201#{worst_year.digits[0] + 1}"
  end

  def average_win_percentage(team_id)
    (result_totals_by_team(team_id)[:wins].to_f / result_totals_by_team(team_id)[:total].to_f).round(2)
  end

  def most_goals_scored(team_id)
    game_info_by_team(team_id).max_by do |game|
      (game.goals).to_i
    end.goals.to_i
  end

  def fewest_goals_scored(team_id)
    game_info_by_team(team_id).min_by do |game|
      (game.goals).to_i
    end.goals.to_i
  end

  def favorite_opponent(team_id)
    opponent = find_opponent_win_percentage(team_id).min_by do |team_id, percentage|
      percentage
    end.first
    find_team_name(opponent)
  end


#-------------TeamStatsHelpers
  def game_info_by_team(team_id)
    @game_teams.select do |game_team|
      game_team.team_id == team_id
    end
  end

  def team_games_by_season(team_id)
    team_games_by_season = {}
    game_info_by_team(team_id).each do |game|
      (team_games_by_season[game.game_id.to_s[0..3]] ||= []) << game
    end
    team_games_by_season
  end

  def win_percentage_by_season(team_id)
    wins = {}
    team_games_by_season(team_id).each do |season, games|
      total_games = 0
      total_wins = 0
      games.each do |game|
       total_wins += 1 if game.result == 'WIN'
       total_games += 1
        end
        wins[season] = (total_wins.to_f / total_games).round(3)
      end
    wins
  end

  def result_totals_by_team(team_id)
    result = {}
    result[:total]  = game_info_by_team(team_id).length
    result[:wins]   = (find_all_game_results(team_id, "WIN")).length
    result[:ties]   = (find_all_game_results(team_id, "TIE")).length
    result[:losses] = (find_all_game_results(team_id, "LOSS")).length
    result
  end

  def find_all_game_results(team_id, result)
    game_info_by_team(team_id).select do |game|
      game.result == result
    end
  end

  def find_opponent_games(team_id)
    game_ids = game_info_by_team(team_id).map(&:game_id)
    @game_teams.select do |game_team|
      game_ids.include?(game_team.game_id) && game_team.team_id != team_id
    end
  end

  def find_opponent_win_percentage(team_id)
    opponent_games_by_team = find_opponent_games(team_id).group_by(&:team_id)
    win_percentage = {}
    opponent_games_by_team.each do |team_id, game_teams|
      total = 0
      opponent_wins = game_teams.count {|game_teams| game_teams.result == 'WIN'}
      win_percentage[team_id] = total += (opponent_wins.to_f / game_teams.length).round(2)
    end
    win_percentage
  end

  def find_team_name(team_id)
    @tracker.team_info(team_id)['team_name']
  end
end
