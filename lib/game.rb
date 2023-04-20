class Game 
  attr_reader :game_data

  def initialize(data)
    @game_data = data
  end

  def highest_total_score
    @game_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end.max
  end

  def lowest_total_score
    @game_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end.min
  end
  
  def percentage_ties
    games = 0
    ties = 0
    @game_data.each do |row|
      if row[:away_goals].to_i == row[:home_goals].to_i
        ties += 1
      elsif row[:away_goals].to_i != row[:home_goals].to_i
        games += 1
      end
    end
    ties.to_f / (games + ties)
  end

  def count_of_games_by_season
    season_count = Hash.new
    @game_data.each do |season, games|
      season_count { season[:season] => games[:game] }
    end
  end
  
end