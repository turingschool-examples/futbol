require "csv"
require_relative "./team"

class TeamCollection

  def self.all(teams_path)
    rows = CSV.read(teams_path, headers: true, header_converters: :symbol)
    rows.reduce([]) do |teams, row|
      teams << Team.new(row)
      teams
    end
  end

end
