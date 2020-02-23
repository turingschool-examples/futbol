require './lib/stats'

class GameStats < Stats
  def initialize(games)
    super(games)
  end

  def highest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.max
  end

  def lowest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.min
  end

  def biggest_blowout
    @games.map { |game| (game.away_goals - game.home_goals).abs }.max
  end

  def percentage_home_wins
    home_wins = @games.find_all { |game| game.away_goals < game.home_goals }
    sum = (home_wins.length).to_f / (@games.length).to_f
    sum.round(2)
  end

  def percentage_visitor_wins
    vistor_wins = @games.find_all { |game| game.away_goals > game.home_goals }
    sum = (vistor_wins.length).to_f / (@games.length).to_f
    sum.round(2)
  end

  def percentage_ties
    ties = @games.count do |game|
      game.away_goals == game.home_goals
    end
    ties.fdiv(@games.length).round(2)
  end

  def count_of_games_by_season
    #sort by number/games_by_season
    @games.reduce(Hash.new(0)) do |games_by_season, game|
      games_by_season[game.season] += 1
      games_by_season
    end
  end

  def average_goals_per_game
    all_goals = @games.sum { |game| game.away_goals + game.home_goals }
    sum = all_goals.to_f / @games.length
    sum.round(2)
  end

  def average_goals_by_season
    goals_per_season = {}
    @games.each do |game|
      if goals_per_season[game.season] == nil
        goals_per_season[game.season] = game.away_goals + game.home_goals
      else
        goals_per_season[game.season] += game.away_goals + game.home_goals
      end
    end
    count = count_of_games_by_season
    @games.reduce(Hash.new(0)) do |average_goals, game|
      average_goals[game.season] = (goals_per_season[game.season].to_f / count[game.season]).round(2)
      average_goals
    end
  end
end
