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
      team_result.game_id.start_with?(season[0..3])
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

  def rival(team_id)
    opponent = find_opponent_win_percentage(team_id).max_by do |team_id, percentage|
      percentage
    end.first
    find_team_name(opponent)
  end

# #-------------TeamStatsHelpers
#   def game_info_by_team(team_id)
#     @game_teams.select do |game_team|
#       game_team.team_id == team_id
#     end
#   end

#   def team_games_by_season(team_id)
#     team_games_by_season = {}
#     game_info_by_team(team_id).each do |game|
#       (team_games_by_season[game.game_id.to_s[0..3]] ||= []) << game
#     end
#     team_games_by_season
#   end

#   def win_percentage_by_season(team_id)
#     wins = {}
#     team_games_by_season(team_id).each do |season, games|
#       total_games = 0
#       total_wins = 0
#       games.each do |game|
#        total_wins += 1 if game.result == 'WIN'
#        total_games += 1
#         end
#         wins[season] = (total_wins.to_f / total_games).round(3)
#       end
#     wins
#   end

#   def result_totals_by_team(team_id)
#     result = {}
#     result[:total]  = game_info_by_team(team_id).length
#     result[:wins]   = (find_all_game_results(team_id, "WIN")).length
#     result[:ties]   = (find_all_game_results(team_id, "TIE")).length
#     result[:losses] = (find_all_game_results(team_id, "LOSS")).length
#     result
#   end

#   def find_all_game_results(team_id, result)
#     game_info_by_team(team_id).select do |game|
#       game.result == result
#     end
#   end

#   def find_opponent_games(team_id)
#     game_ids = game_info_by_team(team_id).map(&:game_id)
#     @game_teams.select do |game_team|
#       game_ids.include?(game_team.game_id) && game_team.team_id != team_id
#     end
#   end

#   def find_opponent_win_percentage(team_id)
#     opponent_games_by_team = find_opponent_games(team_id).group_by(&:team_id)
#     win_percentage = {}
#     opponent_games_by_team.each do |team_id, game_teams|
#       total = 0
#       opponent_wins = game_teams.count {|game_teams| game_teams.result == 'WIN'}
#       win_percentage[team_id] = total += (opponent_wins.to_f / game_teams.length).round(2)
#     end
#     win_percentage
#   end

#   def find_team_name(team_id)
#     @tracker.team_info(team_id)['team_name']
#   end
end
