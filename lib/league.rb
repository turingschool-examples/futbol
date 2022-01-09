
class League
    attr_reader :games, :teams, :game_teams

    def initialize(games, teams, game_teams)
      @games = games
      @teams = teams
      @game_teams = game_teams
  end

  def count_of_teams
    @teams.count
  end

  def best_offense #stat tracker
    offense_avgs_by_team = Hash.new(0.0)
    total_goals_per_team.each do |team_id, total_goals|
      offense_avgs_by_team[team_id] = total_goals_per_team[team_id] / all_games_played(team_id).count
    end
    best_team_id = offense_avgs_by_team.key(offense_avgs_by_team.values.max)
    convert_team_id_to_name(best_team_id)
  end

  def worst_offense #stat tracker
    offense_avgs_by_team = Hash.new(0.0)
    total_goals_per_team.each do |team_id, total_goals|
      offense_avgs_by_team[team_id] = total_goals_per_team[team_id] / all_games_played(team_id).count
    end
    best_team_id = offense_avgs_by_team.key(offense_avgs_by_team.values.min)
    convert_team_id_to_name(best_team_id)
  end

  def games_by_team_id
    @game_teams.group_by {|game| game[:team_id]}
  end

  def collection_of_goals_per_team
    goals_per_team = Hash.new(0)
    games_by_team_id.each do |team_id, game_array|
      goals_per_team[team_id] = game_array.map {|game| game[:goals].to_f}
    end
    goals_per_team
  end

  def total_goals_per_team
    goal_grandtotals_per_team = Hash.new(0)
    collection_of_goals_per_team.each do |team_id, goals_array|
      goal_grandtotals_per_team[team_id] = goals_array.sum
    end
    goal_grandtotals_per_team
  end

  def all_games_played(team_id)
    @game_teams.select do |row|
      row if row[:team_id] == team_id
    end
  end

  def convert_team_id_to_name(team_id)
    name_array = []
    x = @teams.find do |row|
      row[:team_id] == team_id
    end
    x[:teamname]
  end
end
