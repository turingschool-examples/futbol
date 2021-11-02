require 'csv'

class StatTracker

  def initialize(locations_info)
    @games =  locations_info[:games]
    @teams = locations_info[:teams]
    @game_teams = locations_info[:game_teams]
  end


  def self.from_csv(locations)
    locations = {}
    locations[:games] = CSV.read('./data/games_test.csv')
    locations[:teams] = CSV.read('./data/teams_test.csv')
    locations[:game_teams] = CSV.read('./data/game_teams_test.csv')
    StatTracker.new(locations)
  end
end
