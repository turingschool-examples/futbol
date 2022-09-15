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
    wins =0
    @games_data.each { |row| wins += 1 if row[:away_goals].to_i < row[:home_goals].to_i}
    (wins.to_f/games_data.count).round(2)
  end

  def percentage_visitor_wins
    wins =0
    @games_data.each { |row| wins += 1 if row[:away_goals].to_i > row[:home_goals].to_i}
    (wins.to_f/games_data.count).round(2)
  end

  def percentage_ties
    ties =0 
    @games_data.each {|row| ties += 1 if row[:away_goals].to_i == row[:home_goals].to_i}
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
  
  def count_of_goals_by_season
    goals_by_season = {}
    @games_data.each { |row|
      if goals_by_season.include?(row[:season])
        goals_by_season[row[:season]] += ([row[:away_goals].to_f]+[row[:home_goals].to_f]).sum
      elsif goals_by_season.include?(row[:season]) == false
        goals_by_season[row[:season]] = ([row[:away_goals].to_f]+[row[:home_goals].to_f]).sum
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














































































































































  def count_of_teams
    @teams_data.count 
  end
end
