require 'csv'
class StatTracker
  attr_reader :data, 
              :team_file,
              :game_file,
              :game_team_file

  def initialize(data)
    # @data = data
    @game_file = CSV.open data[:games], headers: true, header_converters: :symbol
    @team_file = CSV.open data[:teams], headers: true, header_converters: :symbol
    @game_team_file = CSV.open data[:game_teams], headers: true, header_converters: :symbol
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end