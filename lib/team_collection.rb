require './lib/team'

class TeamCollection
  attr_reader :csv_file_path, :teams

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @teams = []
  end
end
