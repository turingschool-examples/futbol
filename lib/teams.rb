require_relative 'team'
class Teams
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

  def all
    @teams
  end

  def find_by_team_id(team_id)
    
  end
end
