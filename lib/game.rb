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

  def count_of_games_by_season
    season_hash = Hash.new(0)
    @game_data.each do |game|
      season = game[:season]
      season_hash[season] += 1
    end
    season_hash
  end

  def percentage_home_wins
    home_wins = 0
    total_games = 0
    @game_data.each do |row|
      total_games += 1
      if row[:home_goals] > row[:away_goals]
        home_wins +=1
      end
    end
    home_team_win_percent = (home_wins.to_f/total_games).round(2)
  end

  def percentage_visitor_wins
    away_wins = 0
    total_games = 0
    @game_data.each do |row|
      total_games += 1
      if row[:home_goals] < row[:away_goals]
        away_wins +=1
      end
    end
    visitor_win_percent = (away_wins.to_f/total_games).round(2)
  end

  def percentage_ties
    total_games = 0
    ties = 0
    @game_data.each do |row|
      total_games += 1
      if row[:home_goals] == row[:away_goals]
        ties += 1
      end
    end
    tie_percent = (ties.to_f/total_games).round(2)
  end

  def goals_by_season
    goals_by_season = Hash.new(0)
    @game_data.each do |game|
      season = game[:season]
      total_goals = game[:home_goals].to_f + game[:away_goals].to_f
      goals_by_season[season] += total_goals
    end
    goals_by_season
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

  def average_goals_by_season
    average_goals_by_season = Hash.new(0)
    goals_by_season.each do |season, total_goals|
      average_goals_by_season[season] = (total_goals / count_of_games_by_season[season]).round(2)
    end
    average_goals_by_season
  end
end