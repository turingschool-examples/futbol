require 'csv'
require './lib/stat_tracker'
require './lib/team'

class TeamsManager

  def initialize(path, stat_tracker)
    @stat_tracker = stat_tracker
    @teams = []
    create_teams(path)
  end

  def create_teams(teams_table)
    @teams = teams_table.map do |data|
      Team.new(data, self)
    end
  end

end
