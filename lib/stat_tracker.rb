class StatTracker
  attr_reader :teams
  def self.from_csv(hash)
    @teams = []
    CSV.foreach(hash[:teams]) do |row|
       @teams << Team.new(row)
    end
  end

  def initialize
    @teams
  end
end
