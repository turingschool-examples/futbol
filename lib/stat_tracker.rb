require 'CSV'
class StatTracker

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    # read data here?
    @locations = locations
  end
end


# columns = CSV.foreach('./data/teams.csv', headers: false).map { |row| row[0]}
# p columns

table = CSV.parse(File.read('./data/game_teams.csv'), headers: true, header_converters: :symbol)
# p table.by_row[0]
# p table.by_col[0]
p table.first.to_h
