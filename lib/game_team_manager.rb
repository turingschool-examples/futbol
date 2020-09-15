require_relative 'game_teams'
require_relative 'shared_calc'
require_relative 'csv_module'

class GameTeamManager
  include SharedCalculations, CSVModule
  attr_reader :game_teams
  def initialize(locations, stat_tracker) # I need a test
    @stat_tracker = stat_tracker
    @game_teams = generate_data(locations, GameTeams)
  end

  def goal_avg_per_team(team_id, home_away)
    total = @game_teams.reduce([]) do |goal_array, game_team|
      goal_array << game_team.goals if game_team.team_id == team_id && home_away == game_team.HoA
      goal_array << game_team.goals if game_team.team_id == team_id && home_away == ''
      goal_array
    end
    (total.sum.to_f/total.count).round(2)
  end

  def best_offense
    team_data.max_by{|team| goal_avg_per_team(team.team_id, '')}.team_name
  end

  def worst_offense
    team_data.min_by{|team| goal_avg_per_team(team.team_id, '')}.team_name
  end

  def highest_scoring_visitor
    team_data.max_by{|team| goal_avg_per_team(team.team_id, 'away')}.team_name
  end

  def highest_scoring_home_team
    team_data.max_by{|team| goal_avg_per_team(team.team_id, 'home')}.team_name
  end

  def lowest_scoring_visitor
    team_data.min_by{|team| goal_avg_per_team(team.team_id, 'away')}.team_name
  end

  def lowest_scoring_home_team
    team_data.min_by{|team| goal_avg_per_team(team.team_id, 'home')}.team_name
  end

  def team_data
    @stat_tracker.team_manager.teams
  end

  def game_ids_by_team(id)
    game_teams.select { |game_team| game_team.team_id == id }.map(&:game_id)
  end

  def game_team_info(game_id)
    game_teams.select do |game_team|
      game_team.game_id == game_id
    end.reduce({}) do |collector, game|
      collector[game.team_id] = game.game_team_info
      collector
    end
  end

  def game_teams_data_for_season(season_id)
    @game_teams.find_all { |game| game.game_id[0..3] == season_id[0..3] }
  end

  def season_coaches(season_id)
    game_teams_data_for_season(season_id).map { |game| game.head_coach }.uniq
  end

  def winningest_coach(season_id)
    season_coaches(season_id).max_by {|coach| coaches_by_win_percentage(season_id,coach)}
  end

  def worst_coach(season_id)
    season_coaches(season_id).min_by {|coach| coaches_by_win_percentage(season_id,coach)}
  end

  def coaches_by_win_percentage(season_id, coach)
    coaches_array = []
    count = 0
    game_teams_data_for_season(season_id).each do |game|
        coaches_array << game if game.head_coach == coach && game.result == 'WIN'
      count += 1 if game.head_coach == coach
    end
      ((coaches_array.count.to_f / count) * 100 ).round(2)
  end

  def total_shots_by_team(season_id, team)
    game_teams_data_for_season(season_id).sum do |game|
      (game.shots if game.team_id == team).to_i
    end
  end

  def total_goals_by_team(season_id, team)
    game_teams_data_for_season(season_id).sum do |game|
      (game.goals if game.team_id == team).to_i
    end
  end

  def season_teams(season_id)
    game_teams_data_for_season(season_id).map{ |game| game.team_id }.uniq
  end

  def team_accuracy(season_id)
    team_hash = {}
    season_teams(season_id).each do |team|
      ratio = total_goals_by_team(season_id, team).to_f / total_shots_by_team(season_id, team)
      team_hash[team] = ratio.round(6)
    end
    team_hash
  end

  def most_accurate_team(season_id)
    return_max(team_accuracy(season_id))
  end

  def least_accurate_team(season_id)
    return_min(team_accuracy(season_id))
  end

  def total_tackles(season_id)
    tackles_hash = {}
    season_teams(season_id).each do |team|
      tackles_hash[team] = total_tackles_helper(season_id, team)
    end
    tackles_hash
  end

  def total_tackles_helper(season_id, team)
    game_teams_data_for_season(season_id).sum do |game|
      (game.tackles if game.team_id == team).to_i
    end
  end

  def most_tackles(season_id)
    return_max(total_tackles(season_id))
  end

  def fewest_tackles(season_id)
    return_min(total_tackles(season_id))
  end

end
