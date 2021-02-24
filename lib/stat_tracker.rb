require 'csv'
require './lib/team_module'

class StatTracker
  attr_reader :teams

  def initialize(teams)
    @teams = teams
  end

  def self.from_csv(locations)
    require 'pry'; binding.pry
  end


end
