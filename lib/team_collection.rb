require_relative 'team'
require 'CSV'

class TeamCollection
  attr_reader :teams

  def initialize(csv_file_path)
    @teams = create_teams(csv_file_path)
  end

  def create_teams(csv_file_path)
    csv = CSV.foreach("#{csv_file_path}", headers: true, header_converters: :symbol)
    csv.map { |row| Team.new(row) }
  end

  def assocate_team_id_with_team_name

  end

end
