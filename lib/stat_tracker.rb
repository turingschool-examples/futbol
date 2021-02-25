require 'csv'
require 'active_support'
#require './lib/helper_modules/csv_to_hashable.rb'
class StatTracker 
  #include CsvToHash
  attr_reader :games, :game_teams, :teams
  def initialize
    #from_csv(locations)
    @games = GameTable.new('./data/games.csv')
    @game_teams = GameTeamTable.new('./data/game_teams.csv')
    @teams = TeamsTable.new('./data/teams.csv')
  end

  # def highest_score
  #   self.from_csv(csv_files)
    
  # end

  def send_team_data(teams = '@teams')
    @teams
  end
  def random_task
    @teams
  end

  def call_test
    @games.other_call(@teams)
  end
end


