class LeagueStats
  attr_reader :game_data,
              :team_data,
              :games_teams

  def initialize(current_stat_tracker)
    @game_data = current_stat_tracker.games
    @team_data = current_stat_tracker.teams
    @games_teams = current_stat_tracker.games_teams
  end

  def count_of_teams
    @team_data.count
  end

  def all_teams_ids
    team_id = []
    @games_teams.each do |row|
      team_id << row['team_id'].to_i
    end
    team_id.uniq
  end

  def average_goals_per_team(team_id_integer)
    game_counter = 0
    goals_per_game = []
    @games_teams.each do |row|
      if row['team_id'].to_i == team_id_integer
        goals_per_game << row['goals'].to_i
        game_counter += 1
      end
    end
    (goals_per_game.sum.to_f / game_counter).round(2)
  end

  def convert_team_id_to_name(team_id_integer)
    name_array = []
    @team_data.each do |row|
      if row['team_id'].to_i == team_id_integer
        name_array << row['teamName']
      end
    end
    name_array[0]
  end

  def best_offense
    team_goal_hash = {}
    team_id = all_teams_ids
    team_id.each do |id|
      team_goal_hash[id] = average_goals_per_team(id.to_i)
    end
    best_team = team_goal_hash.key(team_goal_hash.values.max)
    convert_team_id_to_name(best_team)
  end

  def worst_offense
    team_goal_hash = {}
    team_id = all_teams_ids
    team_id.each do |id|
      team_goal_hash[id] = average_goals_per_team(id.to_i)
    end
    worst_team = team_goal_hash.key(team_goal_hash.values.min)
    convert_team_id_to_name(worst_team)
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
    (goals_per_game.sum.to_f / game_counter).round(2)
  end

  ## This is a redundant method that needed to be used because we are using
  ## a test data set. When using entire data set, refactor into one team_ids
  ## method
  def all_teams_away_ids
    team_id = []
    @game_data.each do |row|
      team_id << row['away_team_id'].to_i
    end
    team_id.uniq
  end

  def highest_scoring_visitor
    team_goal_hash = {}
    team_id = all_teams_away_ids
    team_id.each do |id|
      team_goal_hash[id] = average_away_goals_per_team(id.to_i)
    end
    best_away_team = team_goal_hash.key(team_goal_hash.values.max)
    convert_team_id_to_name(best_away_team)
  end

  def lowest_scoring_visitor
    team_goal_hash = {}
    team_id = all_teams_away_ids
    team_id.each do |id|
      team_goal_hash[id] = average_away_goals_per_team(id.to_i)
    end
    worst_away_team = team_goal_hash.key(team_goal_hash.values.min)
    convert_team_id_to_name(worst_away_team)
  end

  def all_teams_home_ids
    team_id = []
    @game_data.each do |row|
      team_id << row['home_team_id'].to_i
    end
    team_id.uniq
  end
end
