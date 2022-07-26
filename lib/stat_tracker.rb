require 'csv'

class StatTracker
  attr_reader :locations,
              :games_data,
              :teams_data,
              :game_teams_data

  def initialize(locations)
    @locations = locations
    @games_data = CSV.open(@locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.open(@locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.open(@locations[:game_teams], headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    new_stat_tracker = StatTracker.new(locations)#games_data, teams_data, game_teams_data)
  end


  # Game statistics 
  def highest_total_score
    scores = @games_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i 
    end
    scores.max
  end

  def lowest_total_score
  
  end

  def percentage_home_wins
    
  end

  def percentage_visitor_wins

  end

  def percentage_ties

  end

  def count_of_games_by_season

  end

  def average_goals_per_game

  end

  def average_goals_by_season

  end


# League Statistics

  def count_of_teams

  end

  def best_offense

  end

  def worst_offense

  end

  def highest_scoring_visitor

  end

  def highest_scoring_home_team

  end

  def lowest_scoring_visitor

  end

  def lowest_scoring_home_team

  end


# Season Statistics

def winningest_coach

end

def worst_coach

end

def most_accurate_team

end

def least_accurate_team

end

def most_tackles

end

def fewest_tackles

end


# Team Statistics

def team_info

end

def best_season

end

def worst_season

end

def average_win_percentage

end

def most_goals_scored

end

def fewest_goals_scored

end

def favorite_opponent

end

def rival

end
