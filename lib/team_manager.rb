require 'csv'
require './lib/team'

class TeamManager
  attr_accessor :data

  def initialize(path)
    # returns an array of Team objects that each possess header attributes
    @data = load_file(path)
  end

  def load_file(path)
    CSV.read(path)[1..-1].collect do |row|
      Team.new(row)
    end
  end
end
