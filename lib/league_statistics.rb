require_relative "team_data"
require_relative "game_team_data"
class LeagueStatistics

  def initialize
    @team_name_by_id = Hash.new{}
    @goals_by_id = Hash.new{ |hash, key| hash[key] = 0 }
    @games_played_by_id = Hash.new{ |hash, key| hash[key] = 0 }
    @average_goals_by_id = Hash.new{}

  end

  def all_teams
    TeamData.create_objects
  end

  def all_game_teams
    GameTeamData.create_objects
  end

  def count_of_teams
    all_teams.size
  end

  def offense_suite
    get_team_name_by_id
    average_goals_by_id
  end

  def get_team_name_by_id
    all_teams.each do |team|
      @team_name_by_id[team.team_id] = team.team_name
    end
    @team_name_by_id
  end

  def best_offense
    offense_suite
    best_offense_id = @average_goals_by_id.invert.max[1]
    @team_name_by_id[best_offense_id]
  end

  def worst_offense
    offense_suite
    worst_offense_id = @average_goals_by_id.invert.min[1]
    @team_name_by_id[worst_offense_id]
  end

  def by_id_suite
    goals_by_id
    games_by_id
  end
  
  def average_goals_by_id
    by_id_suite
    @goals_by_id.each do |team_id, goal|
      @average_goals_by_id[team_id] = (goal.to_f / @games_played_by_id[team_id]).round(2)
    end
    @average_goals_by_id
  end

  def goals_by_id
    all_game_teams.each do |game_team|
      @goals_by_id[game_team.team_id] += game_team.goals
    end
    @goals_by_id
  end

  def games_by_id
    all_game_teams.each do |game_team|
      @games_played_by_id[game_team.team_id] += 1
    end
    @games_played_by_id
  end
end
