
require 'CSV'
require './lib/team'

class TeamsRepo
  attr_reader :parent, :teams

  def initialize(path, parent)
    @parent = parent
    @teams = create_teams(path)
  end

  def create_teams(path)
    rows = CSV.readlines(path, headers: :true , header_converters: :symbol)

    rows.map do |row|
      Team.new(row, self)
    end
  end
end
