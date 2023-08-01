require 'csv'
class StatTracker
  attr_reader :data, 
              :team_files,
              :game_files,
              :game_team_files

  def initialize(data)
    # @data = data
    @game_files = CSV.open data[:games], headers: true, header_converters: :symbol
    @team_files = CSV.open data[:teams], headers: true, header_converters: :symbol
    @game_team_files = CSV.open data[:game_teams], headers: true, header_converters: :symbol
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end