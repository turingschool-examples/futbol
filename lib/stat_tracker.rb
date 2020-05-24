require 'csv'

class StatTracker

  def intialize(path)
    @path = path
  end

  def self.from_csv(path)
    StatTracker.new(path)
  end

  def teams(path)
    @teams = CSV.read(path[:teams], headers: true)
  end

  
end
