require 'csv'
require 'pry'
require_relative './game_stats'
require_relative './season_stats'
require_relative './team_stats.rb'
require_relative './league_stats'
require_relative './file_opener'

class StatTracker < FileOpener
  attr_reader :games, :teams, :game_teams
  
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end
  
  include GameStats
  include TeamStats
  include LeagueStats
  include SeasonStats

  def return_column(data_set, column)
    all_results = []
    data_set.each do |rows|
      all_results << rows[column]
    end
    all_results
  end
  
  def team_finder(team_id)
    @teams.find { |team| team[:team_id] == team_id }[:teamname]
  end

  #REFACTOR INTO A SUPERCLASS CALLED FILEOPENER
  def self.from_csv(locations)
    open_files(locations)
  end
end
