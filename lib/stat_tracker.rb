require 'csv'

class StatTracker

  def initialize(filenames)
    filenames.each do |k, v|
      puts CSV.read(v)
    end
  end

  def self.from_csv(filenames)
    self.new(filenames)
  end
end
