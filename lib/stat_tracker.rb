require 'CSV'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams)
    @games = games
    @teams = teams
    # @game_team = game_team
  end

  def average_goals_per_game
    sum = 0

    @games.games.each do |game|
      sum += (game.away_goals.to_i + game.home_goals.to_i)
    end

    (sum.to_f / @games.games.length).round(2)
  end

  def average_goals_by_season
    averages = {}

    @games.games.each do |game|
      if !averages.key?(game.season.to_i)
        averages[game.season.to_i] = (game.home_goals.to_i + game.away_goals.to_i)
      else
        averages[game.season.to_i] += (game.home_goals.to_i + game.away_goals.to_i)
      end
    end

    # require 'pry'; binding.pry
    averages
  end
end
