require './lib/stats'

class GameStats < Stats

  def initialize(games)
    @games = games 
  end

  def total_scores
    game_sums = @games.map do |game|
      game[:away_goals] + game[:home_goals]
    end.sort
  end

  def highest_total_score
    total_scores.last
  end

  def lowest_total_score
    total_scores.first
  end

  def percentage_home_wins
    total_of_home_games = 0
    wins_at_home = 0 
    @game_teams.each do | k, v |
      if k[:hoa] == "home"
        total_of_home_games += 1
      end
      if k[:hoa] == "home" && k[:result] == "WIN"
        wins_at_home += 1
      end
    end
    percent_win = ((wins_at_home / total_of_home_games.to_f)).round(2)
  end

  def percentage_visitor_wins
    total_of_home_games = 0
    losses_at_home = 0 
    @game_teams.each do | k, v |
      if k[:hoa] == "home"
        total_of_home_games += 1
      end
      if k[:hoa] == "home" && k[:result] == "LOSS"
        losses_at_home += 1
      end
    end
    percent_loss = ((losses_at_home / total_of_home_games.to_f)).round(2)
  end

  def percentage_ties
    ties = 0 
    total_of_games = @game_teams.count
    @game_teams.each do | k, v |
      if k[:result] == "TIE"
        ties += 1
      end
    end
    percent_ties = ((ties / total_of_games.to_f)).round(2)
  end

  def count_of_games_by_season
    new_hash = Hash.new(0) 
    games.each {|game| new_hash[game[:season]] += 1}
    return new_hash
  end

  def average_goals_per_game 
    goals = 0 
    games.each {|game| goals += (game[:away_goals] + game[:home_goals])}
    average = (goals.to_f/(games.count.to_f)).round(2)
    return average
  end

  def average_goals_by_season
    new_hash = Hash.new(0) 
    games.each {|game| new_hash[game[:season]]  = season_goals(game[:season])}
    return new_hash
  end

  def season_goals(season)
    number = 0
    goals = 0
    games.each do |game|
      if game[:season] == season
        number += 1 
        goals += (game[:away_goals] + game[:home_goals])
      end
    end
    average = (goals.to_f/number.to_f).round(2)
  end

end