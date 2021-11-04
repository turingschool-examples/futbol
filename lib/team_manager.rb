require 'CSV'
require 'pry'

require_relative './teams'

class TeamManager
  attr_reader :team_objects, :team_path

  def initialize(team_path)
    @team_path = './data/teams.csv'
    # @stat_tracker = stat_tracker
    @team_objects = (
      objects = []
      CSV.foreach(team_path, headers: true, header_converters: :symbol) do |row|
        objects << Teams.new(row)
      end
      objects)
  end
end
