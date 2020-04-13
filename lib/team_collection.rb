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

  def team_info(team_id)
     found_team = @teams.find do |team|
       team.team_id == team_id
     end
     {
       :team_id => found_team.team_id,
       :franchise_id => found_team.franchise_id,
       :team_name => found_team.team_name,
       :abbreviation => found_team.abbreviation,
       :link => found_team.link
     }
  end
end
