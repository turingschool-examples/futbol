require 'csv'
class League
  attr_reader :data
  
  def initialize(data)
    @data = data
  end

  def count_of_teams
    @data.count 
  end

  def team_goals_per_game
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

  def team_average_goals_per_game
    team_average = Hash.new
    team_goals_per_game.each do |team_id, goals_per_game|
      team_average[team_id] = (goals_per_game.sum.to_f / goals_per_game.size.to_f).round(3)
    end
    team_average
    require 'pry'; binding.pry
  end

  def team_name_from_id
    @teams_data.each do |row|
      if highest_average[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end

  def best_offense
    team_goals = Hash.new
    @game_teams_data.each do |row|
      if team_goals[row[:team_id]] != nil
        team_goals[row[:team_id]].push(row[:goals].to_i)
      else
        team_goals[row[:team_id]] = [row[:goals].to_i]
      end
    end

    team_average = Hash.new
    team_goals.each do |team_id, goals_per_game|
      team_average[team_id] = (goals_per_game.sum.to_f / goals_per_game.size.to_f).round(3)
    end
    
    highest_average = team_average.max_by{ |id, average| average }

    @teams_data.each do |row|
      if highest_average[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end

  def worst_offense
    team_goals = Hash.new
    @game_teams_data.each do |row|
      if team_goals[row[:team_id]] != nil
        team_goals[row[:team_id]].push(row[:goals].to_i)
      else
        team_goals[row[:team_id]] = [row[:goals].to_i]
      end
    end

    team_average = Hash.new
    team_goals.each do |team_id, goals_per_game|
      team_average[team_id] = (goals_per_game.sum.to_f / goals_per_game.size.to_f).round(3)
    end
    
    lowest_average = team_average.min_by{ |id, average| average }

    @teams_data.each do |row|
      if lowest_average[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end

  def highest_scoring_visitor
    away_team_goals = Hash.new
    @game_teams_data.each do |row|
      if away_team_goals[row[:team_id]] != nil && row[:hoa] == 'away'
        away_team_goals[row[:team_id]].push(row[:goals].to_i)
      elsif row[:hoa] == 'away'
        away_team_goals[row[:team_id]] = [row[:goals].to_i]
      end
    end

    away_team_average = Hash.new
    away_team_goals.each do |team_id, goals_per_game|
      away_team_average[team_id] = (goals_per_game.sum.to_f / goals_per_game.size.to_f).round(3)
    end

    highest_average = away_team_average.max_by{ |id, average| average }

    @teams_data.each do |row|
      if highest_average[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end

  def highest_scoring_home_team
    home_team_goals = Hash.new
    @game_teams_data.each do |row|
      if home_team_goals[row[:team_id]] != nil && row[:hoa] == 'home'
        home_team_goals[row[:team_id]].push(row[:goals].to_i)
      elsif row[:hoa] == 'home'
        home_team_goals[row[:team_id]] = [row[:goals].to_i]
      end
    end

    home_team_average = Hash.new
    home_team_goals.each do |team_id, goals_per_game|
      home_team_average[team_id] = (goals_per_game.sum.to_f / goals_per_game.size.to_f).round(3)
    end

    highest_average = home_team_average.max_by{ |id, average| average }

    @teams_data.each do |row|
      if highest_average[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end

  def lowest_scoring_visitor
    away_team_goals = Hash.new
    @game_teams_data.each do |row|
      if away_team_goals[row[:team_id]] != nil && row[:hoa] == 'away'
        away_team_goals[row[:team_id]].push(row[:goals].to_i)
      elsif row[:hoa] == 'away'
        away_team_goals[row[:team_id]] = [row[:goals].to_i]
      end
    end

    away_team_average = Hash.new
    away_team_goals.each do |team_id, goals_per_game|
      away_team_average[team_id] = (goals_per_game.sum.to_f / goals_per_game.size.to_f).round(3)
    end

    lowest_average = away_team_average.min_by{ |id, average| average }

    @teams_data.each do |row|
      if lowest_average[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end

  def lowest_scoring_home_team
    home_team_goals = Hash.new
    @game_teams_data.each do |row|
      if home_team_goals[row[:team_id]] != nil && row[:hoa] == 'home'
        home_team_goals[row[:team_id]].push(row[:goals].to_i)
      elsif row[:hoa] == 'home'
        home_team_goals[row[:team_id]] = [row[:goals].to_i]
      end
    end

    home_team_average = Hash.new
    home_team_goals.each do |team_id, goals_per_game|
      home_team_average[team_id] = (goals_per_game.sum.to_f / goals_per_game.size.to_f).round(3)
    end

    lowest_average = home_team_average.min_by{ |id, average| average }

    @teams_data.each do |row|
      if lowest_average[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end
end