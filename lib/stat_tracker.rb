class StatTracker

  def self.from_csv(data)

    StatTracker.new(data)
  end

  def initialize(data)
    @data = data
  end
end
