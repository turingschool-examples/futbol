require 'csv'
require_relative './teams'
require './helpable'

class TeamsStats
  include Helpable

  attr_reader :teams
  def initialize(teams)
    @teams = teams
  end

  def self.from_csv(location)
    teams = CSV.parse(File.read(location), headers: true, header_converters: :symbol).map(&:to_h)
    teams_as_objects = teams.map { |row| Teams.new(row) }
    TeamsStats.new(teams_as_objects)
  end

  #methods

end
