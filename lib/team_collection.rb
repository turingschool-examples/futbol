require 'csv'
class TeamCollection

  @@team_path = './data/teams.csv'

  def initialize
    rows = CSV.read(@@team_path, headers: true, header_converters: :symbol)
    @teams = []
    rows.each do |row|
      @teams << Team.new(row)
    end
  end

  def all
    @teams
  end

end
