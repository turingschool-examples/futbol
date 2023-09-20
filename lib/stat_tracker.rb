require "csv"
class StatTracker
  attr_reader :contents,
  
  def self.from_csv(file_name)
    @contents = CSV.read file_name, headers: true, header_converters: :symbol
  end
##in pry you can then do stat_tracker[:team_id] and it will print stuff
end