require 'csv'

class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data
  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end.max
  end

  def lowest_total_score
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end.min
  end

  def percentage_home_wins
    wins =0
    @games_data.each do |row| 
      if row[:away_goals].to_i < row[:home_goals].to_i
        wins += 1
      end
    end
    (wins.to_f/games_data.count).round(2)
  end

  def percentage_visitor_wins
    wins =0
    @games_data.each do |row| 
      if row[:away_goals].to_i > row[:home_goals].to_i
        wins += 1
      end
    end
    (wins.to_f/games_data.count).round(2)
  end

  def percentage_ties
    ties =0 
    @games_data.each do |row| 
      if row[:away_goals].to_i == row[:home_goals].to_i
        ties += 1
      end
    end
    (ties.to_f/games_data.count).round(2)
  end

  def count_of_games_by_season
    games_by_season = {}
    @games_data.each do |row|
      if games_by_season.include?(row[:season])
        games_by_season[row[:season]] += 1
      elsif games_by_season.include?(row[:season]) == false
        games_by_season[row[:season]] = 1
      end
    end
    games_by_season
  end

  def average_goals_per_game
    total_goals = @games_data.map do |row| 
      (row[:away_goals].to_i + row[:home_goals].to_i)
    end
    (total_goals.sum / @games_data.count.to_f).round(2)
  end

  def average_goals_by_season
    average_goals = {}
    goals_by_season = {}
  
    @games_data.each do |row|
      if goals_by_season.include?(row[:season])
        goals_by_season[row[:season]] += ([row[:away_goals].to_f]+[row[:home_goals].to_i]).sum
      elsif goals_by_season.include?(row[:season]) == false
        goals_by_season[row[:season]] = ([row[:away_goals].to_f]+[row[:home_goals].to_i]).sum
      end
    end
    
    goals_by_season.each do |season, wins|
      count_of_games_by_season.each do |season_number, games|
        if season_number == season
          games
          average_goals[season_number] = (wins/games).round(2)
        end 
      end
    end
    average_goals
  end














































































































































  def count_of_teams
    @teams_data.count 
  end

  # def team_goals_per_game

  # end

  # def team_average_goals_per_game

  # end

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
end
