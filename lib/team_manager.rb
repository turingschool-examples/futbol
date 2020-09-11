require 'csv'

class TeamManager
  attr_reader :teams,
              :tracker
  def initialize(path, tracker)
    @teams = []
    create_underscore_teams(path)
    @tracker = tracker
  end

  def create_underscore_teams(path)
    teams_data = CSV.read(path, headers: true)
    @teams = teams_data.map do |data|
      Team.new(data, self)
    end
  end

  def count_of_teams
    @teams.count
  end
end
