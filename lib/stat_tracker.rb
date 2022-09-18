require 'csv'

class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data
  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    # @data = { games: @games_data, teams: @teams_data,game_teams: @game_teams_data }
    # @league = League.new(@data)
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def total_game_goals
    @games_data.map {|row| row[:away_goals].to_i + row[:home_goals].to_i}
  end

  def highest_total_score
    total_game_goals.max
  end

  def lowest_total_score
    total_game_goals.min
  end

  def percentage_home_wins
    home_wins =0
    @games_data.each { |game| home_wins += 1 if game[:away_goals].to_i < game[:home_goals].to_i}
    (home_wins.to_f/games_data.count).round(2)
  end

  def percentage_visitor_wins
    visitor_wins =0
    @games_data.each { |game| visitor_wins += 1 if game[:away_goals].to_i > game[:home_goals].to_i}
    (visitor_wins.to_f/games_data.count).round(2)
  end

  def percentage_ties
    ties =0 
    @games_data.each {|game| ties += 1 if game[:away_goals].to_i == game[:home_goals].to_i}
    (ties.to_f/games_data.count).round(2)
  end

  def count_of_games_by_season
    games_by_season = {}
    @games_data.each {|game|
      games_by_season[game[:season]] += 1 if games_by_season.include?(game[:season])
      games_by_season[game[:season]] = 1 if !games_by_season.include?(game[:season])
    }
    games_by_season
  end
  
  def count_of_goals_by_season
    goals_by_season = {}
    @games_data.each { |game|
      if goals_by_season.include?(game[:season])
        goals_by_season[game[:season]] += ([game[:away_goals].to_f]+[game[:home_goals].to_f]).sum
      elsif !goals_by_season.include?(game[:season])
        goals_by_season[game[:season]] = ([game[:away_goals].to_f]+[game[:home_goals].to_f]).sum
      end
    }
    goals_by_season
  end
  
  def average_goals_per_game
    (total_game_goals.sum / @games_data.count.to_f).round(2)
  end
  
  def average_goals_by_season
    average_goals = {}  
    count_of_goals_by_season.each {|season, goals|
      count_of_games_by_season.each {|season_number, games|
        average_goals[season_number] = (goals/games).round(2) if season_number == season
        }}
    average_goals
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

  



















































































































































  def count_of_teams
    @teams_data.count 
  end
# # helper methods 
#   def team_goals_per_game
#     team_goals = Hash.new
#     @game_teams_data.each do |row|
#       if team_goals[row[:team_id]] != nil
#         team_goals[row[:team_id]].push(row[:goals].to_i)
#       else
#         team_goals[row[:team_id]] = [row[:goals].to_i]
#       end
#     end
#     team_goals
#   end

#   def team_average_goals_per_game
#     team_average = Hash.new
#     team_goals_per_game.each do |team_id, goals_per_game|
#       team_average[team_id] = (goals_per_game.sum.to_f / goals_per_game.size.to_f).round(3)
#     end
#     team_average
#   end

#   def team_name_from_id_average(average)
#     @teams_data.each do |row|
#       if average[0] == row[:team_id]
#         return row[:teamname]
#       end
#     end
#   end
# stat methods 

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

