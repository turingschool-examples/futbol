require 'csv'

class TeamManager
  attr_accessor :data
  
  def initialize
    @data = load_file(path)
  end

  def load_file(path)
    CSV.read(path)[1..-1].collect do |row|
      Team.new(row)
    end
  end
end
