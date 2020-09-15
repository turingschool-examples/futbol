require_relative 'game_teams'
require_relative 'shared_calc'
require_relative 'csv_module'
require_relative 'data_call'


class GameTeamManager
  include SharedCalculations, CSVModule, DataCall
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
    season_teams(season_id).reduce({}) do |team_hash, team|
      team_hash[team] = (total_goals_by_team(season_id, team).to_f / total_shots_by_team(season_id, team)).round(6)
      team_hash
    end
  end

  def most_accurate_team(season_id)
    return_max(team_accuracy(season_id))
  end

  def least_accurate_team(season_id)
    return_min(team_accuracy(season_id))
  end

  def total_tackles(season_id)
    season_teams(season_id).reduce({}) do |tackles_hash, team|
      tackles_hash[team] = total_tackles_helper(season_id, team)
      tackles_hash
    end
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
