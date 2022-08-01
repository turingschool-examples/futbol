require 'csv'
require_relative './teams'
require './helpable'

class TeamStats
  include Helpable

  attr_reader :teams
  def initialize(teams)
    @teams = teams
  end

def self.create_multiple_teams(location)
  teams = CSV.parse(File.read(location), headers: true, header_converters: :symbol).map(&:to_h)
  teams_as_objects = teams.map { |row| Teams.new(row) }
  Teams.new(teams_as_objects)
end
