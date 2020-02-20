require './lib/team'

class TeamCollection
  attr_reader :csv_file_path, :teams

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @teams = []
  end

  def instantiate_team(info)
    Team.new(info)
  end

  def collect_team(team)
    @teams << team
  end
end
