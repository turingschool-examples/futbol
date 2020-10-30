
require 'CSV'
require './lib/team'

class TeamsRepo
  attr_reader :parent, :teams

  def initialize(path, parent)
    @parent = parent
    @teams = create_teams(path)
  end

  def create_teams(path)
    rows = CSV.readlines('./data/teams.csv', headers: :true , header_converters: :symbol)

    rows.map do |row|
      Team.new(row, self)
    end
  end

  def count_of_teams
    @teams.count
  end

  def team_name(id)
   @teams.find do |team|
     team.team_id == id 
    end.team_name
  end
end
