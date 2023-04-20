class Team
  attr_reader :team_id,
              :name

  contents = CSV.open "teams.csv", headers: true, header_converters: :symbol
  contents.each do |row|
    team_id = row[:team_id]
    name = row[:name]
  end

  def initialize(team)
    @team_id = team[:team_id]
    @name = team[:teamname]
  end
end