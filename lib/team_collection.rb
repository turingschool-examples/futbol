require_relative 'team'
require 'csv'

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
    found_team = @teams.find{|team| team.team_id == team_id}
    {
      team_id: found_team.team_id,
      franchise_id: found_team.franchise_id,
      teamname: found_team.teamname,
      abbreviation: found_team.abbreviation,
      link: found_team.link
    }
  end

  def teamname_by_id(team_id)
    @teams.find {|team| team.team_id == team_id}.teamname
  end

end
