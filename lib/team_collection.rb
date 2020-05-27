require "csv"

class TeamCollection
  def initialize(teams_csv)
    @teams_csv = teams_csv
    @rows = CSV.read(@teams_csv, headers: true, header_converters: :symbol)
  end

  def all
    @rows.reduce([]) do |teams, row|
      teams << Team.new(row)
      teams
    end
  end

  def find_by_id(id)
    all.find do |team|
      team.team_id == id
    end 
  end

end
