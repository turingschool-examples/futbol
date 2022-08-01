require 'csv'

require_relative './game_stats'
require_relative './league_stats'
require_relative './season_stats'
require_relative './team_stats'

class StatTracker
  include GameStats
  include LeagueStats
  include SeasonStats
  include TeamStats
  # attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.read(locations[:games], { headers: true, header_converters: :symbol })
    teams = CSV.read(locations[:teams], { headers: true, header_converters: :symbol })
    game_teams = CSV.read(locations[:game_teams], {headers: true, header_converters: :symbol })
    StatTracker.new(games, teams, game_teams)
  end
  
end
