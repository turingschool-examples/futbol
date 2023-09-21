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

  # def average_goals_by_season
  #   agbs = {}
  #   seasons = []
  #   @game_data.each do |row|
  #     seasons << row[:season]
  #   end
  #   seasons = season.uniq
  #   seasons.each do |season|
  #     agbs[season] = 
  #   end
  # end

  def average_goals_by_season
    agbs = {}
    games_by_season1 = 0
    games_by_season2 = 0
    games_by_season3 = 0
    games_by_season4 = 0
    games_by_season5 = 0
    games_by_season6 = 0
    
    goals_by_season1 = 0
    goals_by_season2 = 0
    goals_by_season3 = 0
    goals_by_season4 = 0
    goals_by_season5 = 0
    goals_by_season6 = 0
    
    
    @game_data.each do |row|
    if row[:season] == "20122013"
      games_by_season1 += 1
      goals_by_season1 += row[:home_goals].to_i + row[:away_goals].to_i
    elsif row[:season] == "20162017"
      games_by_season2 += 1
      goals_by_season2 += row[:home_goals].to_i + row[:away_goals].to_i
    elsif row[:season] == "20142015"
      games_by_season3 += 1
      goals_by_season3 += row[:home_goals].to_i + row[:away_goals].to_i
    elsif row[:season] == "20152016"
      games_by_season4 += 1
      goals_by_season4 += row[:home_goals].to_i + row[:away_goals].to_i
    elsif row[:season] == "20132014"
      games_by_season5 += 1
      goals_by_season5 += row[:home_goals].to_i + row[:away_goals].to_i
    elsif row[:season] == "20172018"
      games_by_season6 += 1
      goals_by_season6 += row[:home_goals].to_i + row[:away_goals].to_i
      end
    end
    result1 = (goals_by_season1.to_f/games_by_season1).round(2)
    result2 = (goals_by_season2.to_f/games_by_season2).round(2)
    result3 = (goals_by_season3.to_f/games_by_season3).round(2)
    result4 = (goals_by_season4.to_f/games_by_season4).round(2)
    result5 = (goals_by_season5.to_f/games_by_season5).round(2)
    result6 = (goals_by_season6.to_f/games_by_season6).round(2)
    agbs = {"20122013" => result1,"20162017" => result2,"20142015" => result3,
            "20152016" => result4, "20132014" => result5, "20172018" => result6 }
  end
end