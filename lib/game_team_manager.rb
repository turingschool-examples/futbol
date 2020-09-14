require_relative 'game_teams'
require 'csv'

class GameTeamManager
  attr_reader :game_teams
  def initialize(location, stat_tracker) # I need a test
    @stat_tracker = stat_tracker
    @game_teams = generate_game_teams(location)
  end

  def generate_game_teams(location) # I need a test
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << GameTeams.new(row.to_hash)
    end
    array
  end
  
  def goal_avg_per_team(team_id, home_away)
    goal_array = []
    @game_teams.each do |game|
        if game.team_id == team_id && home_away == game.HoA
          goal_array << game.goals
        elsif game.team_id == team_id && home_away == ''
          goal_array << game.goals
        end
      end
    (goal_array.sum.to_f/goal_array.count).round(2)
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

=======
  def game_ids_by_team(id)
    game_teams.select do |game_team|
      game_team.team_id == id
    end.map(&:game_id)
  end

  def game_team_info(game_id)
    game_teams.select do |game_team|
      game_team.game_id == game_id
    end.reduce({}) do |collector, game|
      collector[game.team_id] = game.game_team_info
      collector
    end
  end

  def team_by_id(team_id)
    @stat_tracker.team_info(team_id)['team_name']
  end

  def game_teams_data_for_season(season_id)
    @game_teams.find_all do |game|
      game.game_id[0..3] == season_id[0..3]
    end
  end

  def season_coaches(season_id)
    game_teams_data_for_season(season_id).map do |game|
      game.head_coach
    end.uniq
  end

  def winningest_coach(season_id)
    coaches_by_win_percentage(season_id).max_by do |_coach, win_percentage|
      win_percentage
    end[0]
  end

  def worst_coach(season_id)
    coaches_by_win_percentage(season_id).min_by do |_coach, win_percentage|
      win_percentage
    end[0]
  end

  def coaches_by_win_percentage(season_id)
    coaches_hash = {}
    season_coaches(season_id).find_all do |coach|
      total_games = game_teams_data_for_season(season_id).count do |game|
        game.head_coach == coach
      end
      total_wins = game_teams_data_for_season(season_id).count do |game|
        game.head_coach == coach && game.result == 'WIN'
      end
      coaches_hash[coach] = ((total_wins.to_f / total_games.to_f) * 100).round(2)
    end
    coaches_hash
  end

  def total_shots_by_team(season_id, team)
    game_teams_data_for_season(season_id).sum do |game|
      if game.team_id == team
        game.shots
      else
        0
      end
    end
  end

  def total_goals_by_team(season_id, team)
    game_teams_data_for_season(season_id).sum do |game|
      if game.team_id == team
        game.goals
      else
        0
      end
    end
  end

  def season_teams(season_id)
    game_teams_data_for_season(season_id).map do |game|
      game.team_id
    end.uniq
  end

  def team_accuracy(season_id)
    team_hash = {}
    season_teams(season_id).each do |team|
      ratio = total_goals_by_team(season_id, team).to_f / total_shots_by_team(season_id, team).to_f
      team_hash[team] = ratio.round(6)
    end
    team_hash
  end

  def most_accurate_team(season_id)
    most_accurate = team_accuracy(season_id).max_by do |_team, accuracy|
      accuracy
    end[0]
    team_by_id(most_accurate)
  end

  def least_accurate_team(season_id)
    least_accurate = team_accuracy(season_id).min_by do |_team, accuracy|
      accuracy
    end[0]
    team_by_id(least_accurate)
  end

  def total_tackles(season_id)
    tackles_hash = {}
    season_teams(season_id).each do |team|
      tackles_hash[team] = total_tackles_helper(season_id, team)
    end
    tackles_hash
  end

  def total_tackles_helper(season_id, team)
    total_tackles = game_teams_data_for_season(season_id).sum do |game|
      if game.team_id == team
        game.tackles
      else
        0
      end
    end
    total_tackles
  end

  def most_tackles(season_id)
    most_tackles_team = total_tackles(season_id).max_by do |_team, tackles|
      tackles
    end[0]
    team_by_id(most_tackles_team)
  end

  def fewest_tackles(season_id)
    fewest_tackles_team = total_tackles(season_id).min_by do |_team, tackles|
      tackles
    end[0]
    team_by_id(fewest_tackles_team)
  end
end
