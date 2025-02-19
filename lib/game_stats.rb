require_relative './stats'
require_relative './seasonable'

class GameStats < Stats
  include Seasonable
  
  def initialize(locations)
    super 
  end

  def highest_total_score
    sums_of_home_away_goals.sort.last
  end

  def lowest_total_score
    sums_of_home_away_goals.sort.first
  end

  def percentage_home_wins
    total_of_home_games = 0
    wins_at_home = 0 
    @game_teams.each do | k, v |
      if k.hoa == "home"
        total_of_home_games += 1
      end
      if k.hoa == "home" && k.result == "WIN"
        wins_at_home += 1
      end
    end
    percent_win = ((wins_at_home / total_of_home_games.to_f)).round(2)
  end

  def percentage_visitor_wins
    total_of_home_games = 0
    losses_at_home = 0 
    @game_teams.each do | k, v |
      if k.hoa == "home"
        total_of_home_games += 1
      end
      if k.hoa == "home" && k.result == "LOSS"
        losses_at_home += 1
      end
    end
    percent_loss = ((losses_at_home / total_of_home_games.to_f)).round(2)
  end

  def percentage_ties
    ties = 0 
    total_of_games = @game_teams.count
    @game_teams.each do | k, v |
      if k.result == "TIE"
        ties += 1
      end
    end
    percent_ties = ((ties / total_of_games.to_f)).round(2)
  end

  def count_of_games_by_season
    new_hash = Hash.new(0) 
    all_games_by_season.each { |season, games| new_hash[season] = games.count }
    return new_hash
  end

  def average_goals_per_game 
    (sums_of_home_away_goals.sum / sums_of_home_away_goals.count.to_f).round(2)
  end

  def average_goals_by_season
    new_hash = Hash.new(0) 
    goal_totals = 0
    all_games_by_season.each do |season, games| 
      games.each do |game|
        goal_totals += (game.away_goals + game.home_goals) 
      end
      new_hash[season] = (goal_totals.to_f / games.count.to_f).round(2)
      goal_totals = 0
    end
    return new_hash
  end
end