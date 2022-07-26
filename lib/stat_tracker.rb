require 'csv'

class StatTracker
  attr_reader 
  def initialize(locations)#games, teams, game_teams)
    # @games = games
    # @teams = teams
    # @game_teams = game_teams
    @locations = locations
  end

  def self.from_csv(locations)
    # games_data = CSV.open locations[:games], headers: true, header_converters: :symbol
    # teams_data = CSV.open locations[:teams], headers: true, header_converters: :symbol
    # game_teams_data = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
    new_stat_tracker = StatTracker.new(locations)#games_data, teams_data, game_teams_data)
    # require 'pry';binding.pry
  end



end
