require_relative 'game_team'
require_relative 'game'
require_relative 'team'
require_relative 'calculable'

class Stats
  include Calculable

  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def team_games_by_season(season) # test
    season_games = @games.find_all{|game| game.season == season}
    season_game_ids = season_games.map{|game| game.game_id}
    @game_teams.find_all{|team| season_game_ids.include?(team.game_id)}
  end

end
