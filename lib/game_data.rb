require 'csv'

class GameData 
  attr_reader :home_wins,
              :away_wins,
              :ties,
              :total_games

  attr_accessor :games

  def initialize
    @games = []
    @home_wins = 0
    @away_wins = 0
    @ties = 0
    @total_games = 0
  end

  def add_games 
    games = CSV.open './data/games.csv', headers: true, header_converters: :symbol
    games.each do |row|
      id = row[:game_id]
      season = row[:season]
      type = row[:type]
      date_time = row[:date_time]
      away = row[:away_team_id]
      home = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      venue = row[:venue]
      venue_link = row[:venue_link]
      @games << Game.new(id, season, type, date_time, away, home, away_goals, home_goals, venue, venue_link)
    end
  end

  def wins_losses
    @games.each do |game|
      if game.home_goals > game.away_goals
        @home_wins += 1
        @total_games += 1
      elsif game.home_goals < game.away_goals
        @away_wins += 1
        @total_games += 1
      elsif game.home_goals == game.away_goals
        @ties += 1 
        @total_games += 1
      end
    end
  end

  def percentage_home_wins
    (@home_wins.to_f / @total_games).round(2)
  end
 
  def percentage_visitor_wins
    (@away_wins.to_f / @total_games).round(2)
  end

  def percentage_ties
    (@ties.to_f / @total_games).round(2)
  end
end