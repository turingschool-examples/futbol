require './lib/league_stats_module'
class LeagueStats

  include LeagueEnumerables

  attr_reader :game_data,
              :team_data,
              :game_teams

  def initialize(current_stat_tracker)
    @game_data = current_stat_tracker.games
    @team_data = current_stat_tracker.teams
    @game_teams = current_stat_tracker.game_teams
  end

  def average_goals_per_team(team_id_integer)
    game_counter = 0
    goals_per_game = []
    @game_teams.each do |row|
      if row['team_id'].to_i == team_id_integer
        goals_per_game << row['goals'].to_i
        game_counter += 1
      end
    end
    average(goals_per_game, game_counter)
  end

  def best_offense
    team_goal_hash = {}
    team_id = all_teams_ids(@team_data)
    team_id.each do |id|
      team_goal_hash[id] = average_goals_per_team(id.to_i)
    end
    convert_team_id_to_name(find_max(team_goal_hash))
  end

  def worst_offense
    team_goal_hash = {}
    team_id = all_teams_ids(@team_data)
    team_id.each do |id|
      team_goal_hash[id] = average_goals_per_team(id.to_i)
    end
    convert_team_id_to_name(find_min(team_goal_hash))
  end

  def average_away_goals_per_team(team_id_integer)
    game_counter = 0
    goals_per_game = []
    @game_data.each do |row|
      if row['away_team_id'].to_i == team_id_integer
        goals_per_game << row['away_goals'].to_i
        game_counter += 1
      end
    end
    average(goals_per_game, game_counter)
  end

  def highest_scoring_visitor
    team_goal_hash = {}

    all_teams_away_ids(@game_data).each do |id|
      team_goal_hash[id] = average_away_goals_per_team(id.to_i)
    end

    convert_team_id_to_name(find_max(team_goal_hash))
  end

  def lowest_scoring_visitor
    team_goal_hash = {}

    all_teams_away_ids(@game_data).each do |id|
      team_goal_hash[id] = average_away_goals_per_team(id.to_i)
    end
    convert_team_id_to_name(find_min(team_goal_hash))
  end

  def average_home_goals_per_team(team_id_integer)
    game_counter = 0
    goals_per_game = []
    @game_data.each do |row|
      if row['home_team_id'].to_i == team_id_integer
        goals_per_game << row['home_goals'].to_i
        game_counter += 1
      end
    end
    average(goals_per_game, game_counter)
  end

  def highest_scoring_home_team
    team_goal_hash = {}

    all_teams_home_ids(@game_data).each do |id|
      team_goal_hash[id] = average_home_goals_per_team(id.to_i)
    end

    convert_team_id_to_name(find_max(team_goal_hash))
  end

  def lowest_scoring_home_team
    team_goal_hash = {}

    all_teams_home_ids(@game_data).each do |id|
      team_goal_hash[id] = average_home_goals_per_team(id.to_i)
    end
    convert_team_id_to_name(find_min(team_goal_hash))
  end
end
