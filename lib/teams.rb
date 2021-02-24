class Teams
  attr_reader :team_id,
              :franchiseID,
              :teamName,
              :abbreviation,
              :stadium,
              :link

  def initialize(info)
    @team_id = info[:team_id]
    @franchiseID = info[:franchiseID]
    @teamName = info[:teamName]
    @abbreviation = info[:abbreviation]
    @stadium = info[:stadium]
    @link = info[:link]
  end
end
