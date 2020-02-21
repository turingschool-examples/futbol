require './lib/team'
require 'csv'

class TeamCollection
  attr_reader :teams

  def initialize(team_data)
    @teams = create_teams(team_data)
  end

  def create_teams(team_data)
    team_data.map do |row|
      Team.new(row.to_h)
    end
  end
end
