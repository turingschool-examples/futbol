require 'CSV'
require_relative 'team'

class TeamCollection
  attr_reader :teams

  def initialize(teams_file_path)
    @teams = from_csv(teams_file_path)
  end

  def from_csv(teams_file_path)
    teams = CSV.read(teams_file_path, headers: true, header_converters: :symbol)
    teams.map do |row|
      Team.new(row)
    end
  end
end
