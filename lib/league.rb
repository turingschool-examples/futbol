require './lib/futbol_data.rb'

class League < FutbolData

  def count_of_teams
    @teams_data.count 
  end

  def best_offense
    high_average = team_goal_average.max_by{ |id, average| average }
    team_name_from_id_average(high_average)
  end

  def worst_offense
    low_average = team_goal_average.min_by{ |id, average| average }
    team_name_from_id_average(low_average)
  end

  def highest_scoring_visitor
    high_average = team_goal_average('away').max_by{ |id, average| average }
    team_name_from_id_average(high_average)
  end

  def highest_scoring_home_team
    high_average = team_goal_average('home').max_by{ |id, average| average }
    team_name_from_id_average(high_average)
  end

  def lowest_scoring_visitor
    low_average = team_goal_average('away').min_by{ |id, average| average }
    team_name_from_id_average(low_average)
  end

  def lowest_scoring_home_team
    low_average = team_goal_average('home').min_by{ |id, average| average }
    team_name_from_id_average(low_average)
  end

  def team_goal_average(hoa = nil)
    if hoa == nil  
      team_goals = team_all_goals
      average_goals(team_goals)
    else
      team_goals = team_hoa_goals(hoa)
      average_goals(team_goals)
    end
  end

  def team_all_goals
    team_goals = Hash.new
    @game_teams_data.each do |row|
      if team_goals[row[:team_id]] != nil
        team_goals[row[:team_id]].push(row[:goals].to_i)
      else
        team_goals[row[:team_id]] = [row[:goals].to_i]
      end
    end
    team_goals
  end

  def team_hoa_goals(hoa)
    team_goals = Hash.new
    @game_teams_data.each do |row|
      if team_goals[row[:team_id]] != nil && row[:hoa] == hoa
        team_goals[row[:team_id]].push(row[:goals].to_i)
      elsif row[:hoa] == hoa
        team_goals[row[:team_id]] = [row[:goals].to_i]
      end
    end
    team_goals
  end

  def average_goals(team_goals)
    team_average = Hash.new
    team_goals.each do |team_id, goals_per_game|
      team_average[team_id] = (goals_per_game.sum.to_f / goals_per_game.size.to_f).round(3)
    end
    team_average
  end

  def team_name_from_id_average(average)
    @teams_data.each do |row|
      if average[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end
end