require 'csv'


class StatTracker
  attr_reader :team_data
  def initialize(locations)
    # @game = game_data_parser(locations[:games])
    @team_data = team_data_parser(locations[:teams])
    # @game_teams = game_teams_data_parser(locations[:game_teams])
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def team_data_parser(file_location)
    contents = CSV.open file_location, headers: true, header_converters: :symbol
    contents.readlines
  end

end