require_relative 'csv'

class LeagueStatistics
  attr_reader 

  def initialize()
    @teams = Teams.create_teams_data_objects(path)
    @game_teams = GameTeams.create_game_teams_data_objects(path)
  end
  
  def count_of_teams
    @teams.count
  end

  def average_goals(team)
    total_goals = game_teams[team].goals
    total_goals.inject(0.0) {|sum, goals| sum + goals}/total_goals.size
  end

  def best_offense
    game_teams.max_by {|team, average_goals| ###}.first.team_name

  end
end
#.MAP!