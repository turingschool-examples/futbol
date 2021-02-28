require 'csv'
#require 'active_support'

class StatTracker
  #include CsvToHash
  attr_reader :games, :game_teams, :teams
  def initialize
    #from_csv(locations)
    @games = GameTable.new('./data/games.csv', self)
    @game_teams = GameTeamTable.new('./data/game_teams.csv', self)
    # @teams = TeamsTable.new('./data/teams.csv', self)
  end

#  # def send_team_data(teams = '@teams')
#     @teams
#   end

#   #def random_task
#     @teams
#   end

#  # def call_test
#     @games.other_call(@teams)
#   end

  def game_by_season
    @games.game_by_season
  end

  def game_by_season(season)
    @game_teams.game_by_season(season)
  end 
end
