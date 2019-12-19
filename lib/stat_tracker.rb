require 'csv'

class StatTracker
  attr_reader :games_collection, :teams_collection, :game_teams_collection

  def initialize(games, teams)
    @games_collection = games
    @teams_collection = teams
    # @game_team = game_team
  end

  def biggest_blowout
    blowout = {}
    @games_collection.games.find_all do |game|
      margin = (game.home_goals.to_i - game.away_goals.to_i).abs
      if blowout.empty?
        blowout[game] = margin
      elsif margin > blowout.values[0]
        blowout.clear
        blowout[game] = margin
      end
    end
    blowout.values.last
  end

  def count_of_games_by_season
    
  end
end
