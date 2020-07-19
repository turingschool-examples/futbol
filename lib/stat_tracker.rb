require 'CSV'

class StatTracker
  def self.from_csv(object, path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      object.add(object.new(row))
    end
  end
end
