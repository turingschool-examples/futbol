class GameStats

  attr_reader :games

  def initialize(games)
    @games = games
  end

  def highest_total_score
    max_score = 0
    @games.each do |game|
      away_goals = game.away_goals.to_i
      home_goals = game.home_goals.to_i
      total_score = away_goals + home_goals
      max_score = total_score if total_score > max_score
    end
    max_score
  end

  def lowest_total_score
    min_score = 0
    @games.each do |game|
      away_goals = game.away_goals.to_i
      home_goals = game.home_goals.to_i
      total_score = away_goals + home_goals
      min_score = total_score if total_score < min_score
    end
    min_score
  end

  def percentage_home_wins
    total_games = @games.length
    home_wins = @games.count { |game| game.home_goals.to_i > game.away_goals.to_i }
    (home_wins.to_f / total_games * 100).round(2)
  end


end