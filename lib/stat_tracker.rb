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
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = read_data(games)
    @teams = read_data(teams)
    @game_teams = read_data(game_teams)
  end

  def self.from_csv(locations)
    games = CSV.open(locations[:games], { headers: true, header_converters: :symbol })
    teams = CSV.open(locations[:teams], { headers: true, header_converters: :symbol })
    game_teams = CSV.open(locations[:game_teams], {headers: true, header_converters: :symbol })
    StatTracker.new(games, teams, game_teams)
  end

  def read_data(data)
    list_of_data = []
    data.each do |row|
      list_of_data << row
    end
    list_of_data
  end 
end
