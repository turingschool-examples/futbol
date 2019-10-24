require 'CSV'
require_relative './team'

class TeamCollection
  attr_reader :teams

  def self.load_data(path)
    teams = {}
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      teams[row[:team_id]] = Team.new(row)
    end

    TeamCollection.new(teams)
  end

  def initialize(teams)
    @teams = teams
  end
end
