require_relative './stat_tracker'
require_relative './statistics'

require 'pry'

class LeagueStatistics < Statistics
  attr_reader :stat_tracker
  def count_of_teams
    @csv_teams[:team_id].length
  end

  def best_offense
    max_average = average_goals_by_team.max_by{|team| team}
    best_offense = @csv_teams.find do |team|
      team[:team_id] == max_average[0]
    end
    best_offense[:teamname]
  end

  # Lowest average score all seasons
  def worst_offense
    min_average = average_goals_by_team.min_by{|team| team[1]}
    worst_offense = @csv_teams.find do |team|
      team[:team_id] == min_average[0]
    end
    worst_offense[:teamname]
  end

  def games_played_by_team
    games_by_team = Hash.new(0)
    @csv_games.each do |game|
      games_by_team[game[:away_team_id]] += 1
      games_by_team[game[:home_team_id]] += 1
    end
    games_by_team
  end

  def goals_scored_by_team
    goals_by_team = Hash.new(0)
    @csv_games.each do |game|
      goals_by_team[game[:away_team_id]] += game[:away_goals].to_i
      goals_by_team[game[:home_team_id]] += game[:home_goals].to_i
    end
    goals_by_team
  end

  def average_goals(goals_scored, games_played)
    goals_scored/games_played.to_f
  end

  def average_goals_by_team
    team_average_goals = Hash.new(0)
    games_and_goals = games_played_by_team.merge(goals_scored_by_team) { |k, o, n| [o,n]}
    games_and_goals.each do |team|
      team_average_goals[team[0]] = average_goals(team[1][1], team[1][0])
    end
    team_average_goals
  end

  # highest_scoring_visitor
  # Name of the team with the highest average score per game across all seasons when they are away.


end
