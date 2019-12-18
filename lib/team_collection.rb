require_relative './team'
require 'csv'

class TeamCollection
  attr_accessor :teams

  def initialize(csv_file_path)
    @teams = create_teams(csv_file_path)
  end

  def from_csv(csv_file_path)
    CSV.read(csv_file_path, headers: true, header_converters: :symbol)
  end

  def create_teams(csv_file_path)
    from_csv(csv_file_path).map do |row|
      Team.new(row)
    end
  end
end
