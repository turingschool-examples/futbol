require 'csv'
require_relative 'team'

class TeamCollection
  attr_reader :teams

  def initialize(csv_file_path)
    @teams = create_teams(csv_file_path)
  end

  def create_teams(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)

    csv.map do |row|
      Team.new(row)
    end
  end

  def count_of_teams
    @teams.length
  end
end
