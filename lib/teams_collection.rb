require 'pry'
class TeamsCollection
  attr_reader :teams
  def initialize(teams_file)
    @games = read_file(teams_file)
  end

  def read_file(teams_file)
    data = CSV.read(teams_file, headers: true, header_converters: :symbol)
    data.map do |row|
      Team.new(row)
    end
  end
end
