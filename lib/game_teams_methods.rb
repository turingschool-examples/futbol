class GameTeamsMethods
attr_reader :game_teams, :game_teams_table
  def initialize(game_teams)
    @game_teams = game_teams
    @game_teams_table = create_table(@game_teams)
  end

  def create_table(file)
    CSV.parse(File.read(file), headers: true)
  end

  def best_offense_team_id_average_goal
    team_averages = average_goals_by_team
    team_averages.max_by do |key, value|
      value
    end
  end

  def worst_offense_team_id_average_goal
    team_averages = average_goals_by_team
    team_averages.min_by do |key, value|
      value
    end
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
end
