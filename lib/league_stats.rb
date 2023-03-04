require_relative 'stats'
require_relative 'league_statables'

class LeagueStats < Stats 
include LeagueStatables

  def initialize(files)
    super
  end

  def count_of_teams
    @teams.count
  end

  def best_offense
    @teams.each do |team|
      if team.team_id == average_goal_by_game.key(average_goal_by_game.values.max)
        return team.team_name
      end
    end
  end

  def worst_offense
    @teams.each do |team|
      if team.team_id == average_goal_by_game.key(average_goal_by_game.values.min)
        return team.team_name
      end
    end
  end

  def highest_scoring_visitor
    @teams.each do |team|
      if team.team_id == average_goal_by_away_team.key(average_goal_by_away_team.values.max)
        return team.team_name
      end
    end
  end
  
  def highest_scoring_home_team
    @teams.each do |team|
      if team.team_id == average_goal_by_home.key(average_goal_by_home.values.max)
        return team.team_name
      end
    end
  end

  def lowest_scoring_visitor
    @teams.each do |team|
      if team.team_id == average_goal_by_away_team.key(average_goal_by_away_team.values.min)
        return team.team_name
      end
    end
  end

  def lowest_scoring_home_team
    @teams.each do |team|
      if team.team_id == average_goal_by_home.key(average_goal_by_home.values.min)
        return team.team_name
      end
    end
  end  
end