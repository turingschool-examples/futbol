require_relative 'game_team'
require_relative 'game'
require_relative 'team'

class Stats

  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def sum_of_goals_in_a_season(season) # game
    full_season = @games.find_all {|game| game.season == season}
    full_season.sum {|game| game.home_goals + game.away_goals}
  end



  def average_of_goals_in_a_season(season) # game
    by_season = @games.find_all {|game| game.season == season}
    average(sum_of_goals_in_a_season(season), by_season.length)
  end

end
