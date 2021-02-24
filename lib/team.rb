class Team
  attr_reader :team_id,
              :franchiseID,
              :teamName,
              :abbreviation,
              :stadium,
              :link

  def initialize(specs)
    @team_id = specs[:team_id]
    @franchiseID = specs[:franchiseID]
    @teamName = specs[:teamName]
    @abbreviation = specs[:abbreviation]
    @stadium = specs[:stadium]
    @link = specs[:link]
  end
end
