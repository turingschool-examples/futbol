require 'CSV'
class StatTracker
  def initialize
  end
  def self.from_csv(locations)
    futbol = []
     locations.each do |key, value|
       key = []
         CSV.foreach(value, headers: true) do |row|
         key << row.to_h()
       end
       futbol << key
     end
     return futbol
   end
 end
