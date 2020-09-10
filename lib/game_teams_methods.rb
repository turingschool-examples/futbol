require 'CSV'

class GameTeamsMethods
attr_reader :game_teams, :game_teams_table
  def initialize(game_teams)
    @game_teams = game_teams
    @game_teams_table = create_table(@game_teams)

  end

  def create_table(file)
    CSV.parse(File.read(file), headers: true)
  end

  def best_offense_team
    team_averages = average_goals_by_team
    team_averages.max_by do |key, value|
      value
    end.first
  end

  def worst_offense_team
    team_averages = average_goals_by_team
    team_averages.min_by do |key, value|
      value
    end.first
  end

  def assign_goals_by_teams
    goals = @game_teams_table['goals']
    team_goals = Hash.new
    @game_teams_table['team_id'].each.with_index do |id, idx|
      if team_goals.has_key?(id)
        team_goals[id] << goals[idx]
      else
        team_goals[id] = [goals[idx]]
      end
    end
    team_goals
  end

  def assign_goals_by_home_or_away_teams(home_away)
    team = find_all_games(home_away).map do |row|
      row['team_id']
    end
    goals = find_all_games(home_away).map do |row|
      row['goals']
    end
    team_id_goal_array(team, goals)
  end

  def team_id_goal_array(team, goals)
    away_team_goals = Hash.new
    team.each.with_index do |id, idx|
      if away_team_goals.has_key?(id)
        away_team_goals[id] << goals[idx]
      else
        away_team_goals[id] = [goals[idx]]
      end
    end
    away_team_goals
  end

  def average_goals_by_team
    team_goals = assign_goals_by_teams
    team_goals.values.each do |goals|
      average_goals = 0
      total = 0
      goals.each do |goal|
        total += goal.to_f
      end
      average_goals = (total / goals.size).round(2)
      team_goals[team_goals.key(goals)] = average_goals
    end
    team_goals
  end

  def highest_scoring_team(home_away)
    away_team_averages = average_goals_by_home_or_away_team(home_away)
    away_team_averages.max_by do |key, value|
      value
    end.first
  end

  def lowest_scoring_team(home_away)
    away_team_averages = average_goals_by_home_or_away_team(home_away)
    away_team_averages.min_by do |key, value|
      value
    end.first
  end

  def average_goals_by_home_or_away_team(home_away)
    away_team_goals = assign_goals_by_home_or_away_teams(home_away)
    away_team_goals.values.each do |goals|
      average_goals = 0
      total = 0
      goals.each do |goal|
        total += goal.to_f
      end
      average_goals = (total / goals.size).round(2)
      away_team_goals[away_team_goals.key(goals)] = average_goals
    end
    away_team_goals
  end

  def find_all_games(home_away)
    @game_teams_table.find_all do |gameteam|
        gameteam["HoA"] == home_away
    end
  end
end
