require 'pry'
class LeagueStatistics
  def initialize(data_set)
    @data_set = data_set
  end

  def count_of_teams
    team_id_array = []
    @data_set[:game_teams].each do |row|
      team_id_array << row[1]
    end
    team_id_array.uniq.count
  end

  def best_offense
    best_team = team_goal_stats_averages.max_by {|team, average| average}
    return_team_name(best_team[0])
  end

  def worst_offense
    worst_team = team_goal_stats_averages.min_by {|team, average| average}
    return_team_name(worst_team[0])
  end

  def highest_scoring_visitor
    best_team = team_goal_stats_averages("away").max_by {|team, average| average}
    return_team_name(best_team[0])
  end

  def highest_scoring_home_team
    best_team = team_goal_stats_averages("home").max_by {|team, average| average}
    return_team_name(best_team[0])
  end

  def team_goal_stats_averages(hoa_type = nil)
    # hoa_type determines which hash is returned
    # "home" and "away" return average goals for the given game type
    # defaults to total games
    teams_goals_stats = Hash.new
    @data_set[:game_teams].each do |row|
      teams_goals_stats[row[:team_id]] = [0, 0]
      # [games, goals]
    end
      if hoa_type == "home"
        @data_set[:game_teams].each do |row|
          if row[:hoa] == "home"
          teams_goals_stats[row[:team_id]][0] += 1
          teams_goals_stats[row[:team_id]][1] += row[:goals].to_f
          end
        end
      elsif hoa_type == "away"
        @data_set[:game_teams].each do |row|
          if row[:hoa] == "away"
            teams_goals_stats[row[:team_id]][0] += 1
            teams_goals_stats[row[:team_id]][1] += row[:goals].to_f
          end
        end
      else
        @data_set[:game_teams].each do |row|
        teams_goals_stats[row[:team_id]][0] += 1
        teams_goals_stats[row[:team_id]][1] += row[:goals].to_f
        end
      end
    teams_goals_stats.each do |team, stat|
      teams_goals_stats[team] = (stat[1] / stat[0]).round(2)
    end
    teams_goals_stats
  end

  def return_team_name(team_id)
    team_name = nil
    @data_set[:teams].each do |row|
      if row[:team_id] == team_id
        team_name = row[:teamname]
      end
    end
    return team_name
  end
end
