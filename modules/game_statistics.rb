require './lib/game'
require './lib/game_teams'

module GameStats
  def highest_total_score
    games = Game.create_list_of_games(@games)
    games.map { |game| game.away_goals + game.home_goals }.sort[-1]
  end
# require 'pry' ;binding pry
  def lowest_total_score
    games = Game.create_list_of_games(@games)
    games.map { |game| game.away_goals + game.home_goals }.sort[0]
  end

  def percentage_home_wins
    games = Game.create_list_of_games(@games)
    ((games.count{ |game| game.home_goals > game.away_goals}) / games.length.to_f).round(2)
  end


  def percentage_visitor_wins
    games = Game.create_list_of_games(@games)
    ((games.count{ |game| game.home_goals < game.away_goals}) / games.length.to_f).round(2)
  end


end
