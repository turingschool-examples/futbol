require './lib/team'
require 'csv'

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

  def create_team_collection
    CSV.foreach(@csv_file_path, headers: true, header_converters: :symbol) do |row|
      collect_team(instantiate_team(row))
    end
  end
end
