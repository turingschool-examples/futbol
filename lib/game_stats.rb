require_relative './classes'

class GameStats < Classes
  
  def initialize(locations)
    super
  end

  def home_wins
    wins_at_home = 0
    @games.each do |game|
      if game.home_goals > game.away_goals
        wins_at_home += 1
      end
    end
    wins_at_home
  end

  def away_wins
    wins_away = 0
    @games.each do |game|
      if game.away_goals > game.home_goals
        wins_away += 1
      end
    end
    wins_away
  end

  def ties
    tied_games = 0.0
    @games.each do |game|
      if game.home_goals == game.away_goals
        tied_games += 1 
      end
    end
    tied_games
  end

  def total_games
    all_games = 0
    @games.each do |game|
      all_games += 1
    end
    all_games
  end

  def percentage_home_wins
    home_wins.fdiv(total_games).round(2)
  end

  def percentage_visitor_wins
    away_wins.fdiv(total_games).round(2)
  end

  def percentage_ties
    ties.fdiv(total_games).round(2)
  end

  def total_scores
    total_scores = @games.map do |game|
      (game.away_goals).to_i + (game.home_goals).to_i
    end.sort
  end

  def highest_total_score
   total_scores.last
  end

  def lowest_total_score
    total_scores.first
  end

  def count_of_games_by_season
    hash = Hash.new(0)
    @games.each do |game|
      hash[game.season] += 1
    end
    hash
  end

  def average_goals_per_game
    total_games = 0
    total_goals = 0
    @games.each do |game|
      total_games += 1
      total_goals += (game.away_goals.to_f + game.home_goals.to_f)
    end
    average = total_goals / total_games
    average.round(2)
  end

  def average_goals_by_season
    average_goals_by_season = Hash.new(0)
    goals_p_season = goals_per_season()
    games_p_season = games_per_season()
    @games.each {|game| average_goals_by_season[game.season] = 0}
    average_goals_by_season.each do |key, value|
      average_goals_by_season[key] = goals_per_season[key].to_f / games_per_season[key].to_f
      average_goals_by_season[key] = average_goals_by_season[key].round(2)
    end
    average_goals_by_season
  end

  #Helper method for average_goals_by_season
  def goals_per_season
    goals_per_season = Hash.new(0)
    @games.each do |game|
      goals_per_season[game.season] += (game.home_goals.to_i + game.away_goals.to_i)
    end
    goals_per_season
  end

  #Helper method for average_goals_by_season  
  def games_per_season
    games_per_season = Hash.new(0)
    @games.each do |game|
      games_per_season[game.season] += 1
    end
    games_per_season
  end


  def highest_home_avg_score
    scores = Hash.new(0)
    @games.each do |game|
      scores[(game.home)] += (game.home_goals).to_i
      scores.max_by{|k,v| v}[0]
    end
  end

  def highest_away_avg_score
    scores = Hash.new(0)
    @games.each do |game|
      scores[(game.away)] += (game.away_goals).to_i
      scores.max_by{|k,v| v}[0]
    end
  end

  def team_goals
    @games.each do |game|
      @away_scores[game.away] += game.away_goals.to_i
      @home_scores[game.home] += game.home_goals.to_i
    end
  end
end


#.merge combines two hashes