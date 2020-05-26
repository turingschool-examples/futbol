require "csv"

class TeamCollection
  def initialize(teams_csv)
    @teams_csv =teams_csv
  end

  def all
    rows = CSV.read(@teams_csv, headers: true, header_converters: :symbol)
    rows.reduce([]) do |teams, row|
      teams << Team.new(row)
      teams
    end
  end
end
