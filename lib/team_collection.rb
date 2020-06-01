require 'csv'

class TeamCollection

  def initialize(team_data)
    rows = CSV.read(team_data, headers: true, header_converters: :symbol)
    @teams = []
    rows.each do |row|
      @teams << Team.new(row)
    end
  end

  def all
    @teams
  end

end
