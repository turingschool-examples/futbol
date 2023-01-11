require_relative './stats'
require_relative './goals_utility'
require_relative './season_utility'
require_relative './team_utility'

class LeagueStats < Stats
  include GoalsUtility
  include SeasonUtility
  include TeamUtility

  def initialize(locations)
    super(locations)
  end

  def count_of_teams
      @teams.count
  end

  def team_goal_avg(team_all_goals_hash)
    team_goal_avg_hash = Hash.new { |hash, key| hash[key] = 0 }
    team_all_goals_hash.each do |team_id, all_goals|
      team_goal_avg_hash[team_id] = (all_goals.sum / all_goals.count.to_f).round(2)
    end
    return team_goal_avg_hash
  end

  def best_team_avg(id)
      @teams.find do |info_line|
        if info_line.team_id == id
          return info_line.team_name
        end
      end
  end

  def best_offense
      team_all_goals_hash = team_id_all_goals
      team_avg = team_goal_avg(team_all_goals_hash)
      id = team_avg.key(team_avg.values.max)
      best_team_avg(id)
  end

  def worst_offense
      team_all_goals_hash = team_id_all_goals
      team_avg = team_goal_avg(team_all_goals_hash)
      id = team_avg.key(team_avg.values.min)
      best_team_avg(id)
  end

  def away_team_goals
    away_team_goals_hash = Hash.new { |hash, key| hash[key] = [] }
    hoa_all_game_teams.each do |hoa, game_team_array|
      game_team_array.each do |game_team|
        if hoa == "away"
          away_team_goals_hash[game_team.team_id] << game_team.goals
        end
      end
    end 
    return away_team_goals_hash 
  end

  def home_team_goals
    home_team_goals_hash = Hash.new { |hash, key| hash[key] = [] }
    hoa_all_game_teams.each do |hoa, game_team_array|
      game_team_array.each do |game_team|
        if hoa == "home"
          home_team_goals_hash[game_team.team_id] << game_team.goals
        end
      end
    end 
    return home_team_goals_hash 
  end

  def avg_team_goals(team_goals_hash)
      team_and_goals_avg = Hash.new { |hash, key| hash[key] = 0 }
      team_goals_hash.each do |team_id, goals_scored|
        goals_scored.each do |goal|
          int_goal = goal.to_i
        end
        team_and_goals_avg[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(6)
      end
      return team_and_goals_avg.sort_by { |key, value| value }
  end

  def highest_scoring_visitor
      team_goals_hash = away_team_goals
      avg_hash = avg_team_goals(team_goals_hash)
      id = avg_hash.reverse.first.first
      team_name(id)
  end

  def highest_scoring_home_team
      team_goals_hash = home_team_goals
      avg_hash = avg_team_goals(team_goals_hash)
      id = avg_hash.reverse.first.first
      team_name(id)
  end

  def lowest_scoring_visitor
      team_goals_hash = away_team_goals
      avg_hash = avg_team_goals(team_goals_hash)
      id = avg_hash.first.first
      team_name(id)
  end

  def lowest_scoring_home_team
      team_goals_hash = home_team_goals
      avg_hash = avg_team_goals(team_goals_hash)
      id = avg_hash.first.first
      team_name(id)
  end
end