class Game
  attr_reader :game_data

  def initialize(game_data)
    @game_data = game_data
  end

  def highest_total_score
    highest_score = @game_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    highest_score.max
  end

  def lowest_total_score
    lowest_score = @game_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    lowest_score.min
  end

  #Work in Progress
  def count_of_games_by_season
    season_hash = {}
    @game_data.each do |game|
      game.each do |key, value|
        
      end
    end
  end

  # GAME STATS: Percentage Category; Home wins, Away wins, Ties. EB
  def percentage_home_wins
    home_wins = 0
    away_wins = 0
    total_games = 0
    ties = 0
    # The following could be a module that gets our basic data and the math on the last three lines would be the entire method.
    @game_data.each do |row|
      total_games += 1
      if row[:home_goals] > row[:away_goals]
        home_wins +=1
      elsif row[:home_goals] == row[:away_goals]
        ties += 1
      else
        away_wins += 1
      end
    end
    home_team_win_percent = (home_wins.to_f/total_games).round(2)
  end

  # GAME STATS: Percentage Category; Home wins, Away wins, Ties. EB
  def percentage_visitor_wins
    home_wins = 0
    away_wins = 0
    total_games = 0
    ties = 0
    # The following could be a module that gets our basic data and the math on the last three lines would be the entire method.
    @game_data.each do |row|
      total_games += 1
      if row[:home_goals] > row[:away_goals]
        home_wins +=1
      elsif row[:home_goals] == row[:away_goals]
        ties += 1
      else
        away_wins += 1
      end
    end
    visitor_win_percent = (away_wins.to_f/total_games).round(2)
  end

  # GAME STATS: Percentage Category; Home wins, Away wins, Ties. EB
  def percentage_ties
    home_wins = 0
    away_wins = 0
    total_games = 0
    ties = 0
    # The following could be a module that gets our basic data and the math on the last three lines would be the entire method.
    @game_data.each do |row|
      total_games += 1
      if row[:home_goals] > row[:away_goals]
        home_wins +=1
      elsif row[:home_goals] == row[:away_goals]
        ties += 1
      else
        away_wins += 1
      end
    end
    tie_percent = (ties.to_f/total_games).round(2)
  end

  def average_goals_per_game
    games = 0
    goals = 0
    @game_data.each do |row|
    games += 1
    goals += row[:home_goals].to_i + row[:away_goals].to_i
    end
    avg = (goals.to_f / games).round(2)
  end
end