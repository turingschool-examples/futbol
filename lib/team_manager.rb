require 'csv'

class TeamManager
  def initialize(path, tracker)
    @teams = []
    create_underscore_teams(path)
    @tracker = tracker
  end
end
