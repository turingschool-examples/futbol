require 'csv'

class League
  def initialize(path)
    @path = path
    @contents = CSV.open "#{path}", headers:true, header_converters: :symbol
  end

  def count_of_teams
    accumulator = []
    @contents.each do |row|
      accumulator << row[:team_id]
    end
    accumulator.uniq!.length
  end
end
