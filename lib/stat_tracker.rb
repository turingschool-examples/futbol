require "csv"

class StatTracker
  def initialize

  end

  def self.from_csv(location)
    location.map do |key, file|
      CSV.open(file, headers: true, header_converters: :symbol)
    end
  end

  def read_csv(location)
    location.map do |key, file|
      CSV.open(file, headers: true, header_converters: :symbol)
      require 'pry'; binding.pry
    end
  end

end