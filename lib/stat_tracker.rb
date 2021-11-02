
class StatTracker

  def initialize
    @filenames = {}
  end

  def self.from_csv(filenames)
    filenames.each do |k, v|
      rows = CSV.read(v)
    end
  end
end
