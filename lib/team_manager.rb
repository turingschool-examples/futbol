require 'csv'

class TeamManager
  def initialize(path, tracker)
    @teams = []
    create_underscore_teams(path)
    @tracker = tracker
  end

  def create_underscore_teams(path)
  end
end
