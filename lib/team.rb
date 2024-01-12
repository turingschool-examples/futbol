class Team
  attr_reader :team_id,
              :teamname,
              :abbreviation,
              :stadium

  def initialize(data)
    @team_id = data[:team_id].to_i
    @teamname = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
  end
end
