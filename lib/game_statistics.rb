require 'csv'
class GameStatistics
  attr_reader :locations,
              :teams_data,
              :game_data,
              :game_team_data

  def initialize(locations)
    @locations = locations
    @game_data = CSV.open locations[:games], headers: true, header_converters: :symbol
    @teams_data = CSV.open locations[:teams], headers: true, header_converters: :symbol
    @game_team_data = CSV.open locations[:game_teams], headers: true, header_converters: :symbol  
  end

  def percentage_calculator(portion, whole)
    percentage_return = (portion / whole).round(2)
  end

  def highest_total_score
    highest_total_score = 0
    @game_data.each do |row|
    total_score = row[:away_goals].to_i + row[:home_goals].to_i #away_goals + home_goals
    highest_total_score = total_score if total_score > highest_total_score
    end
    highest_total_score
  end

  def lowest_total_score
    lowest_total_score = nil
    @game_data.each do |row|
    total_score = row[:away_goals].to_i + row[:home_goals].to_i #away_goals + home_goals
      if lowest_total_score == nil || total_score < lowest_total_score
        lowest_total_score = total_score
      end
    end
    lowest_total_score
  end
  
  def percentage_home_wins  
    total_games = 0
    home_team_wins = 0
    @game_data.each do |row|
      total_games += 1.0
      if row[:home_goals].to_f > row[:away_goals].to_f 
        home_team_wins += 1.0
      end
    end
    percentage_calculator(home_team_wins, total_games)
  end

  def percentage_visitor_wins  
    total_games = 0
    visitor_team_wins = 0
    @game_data.each do |row|
      total_games += 1.00
      if row[:away_goals].to_f > row[:home_goals].to_f
        visitor_team_wins += 1.00
      end
    end
    percentage_calculator(visitor_team_wins, total_games)
  end

  def percentage_ties
    total_games = 0
    tied_games = 0
    @game_data.each do |row|
      total_games += 1.00
      if row[:away_goals].to_f == row[:home_goals].to_f
        tied_games += 1.00
      end
    end
    percentage_calculator(tied_games, total_games)
  end  
end