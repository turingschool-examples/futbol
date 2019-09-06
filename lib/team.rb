class Team
  attr_reader :team_id,
              :franchiseId,
              :teamName,
              :abbreviation,
              :stadium,
              :link

  def initialize(row)

    @team_id      = row["team_id"].to_i
    @franchiseId  = row["franchiseId"]
    @teamName     = row["teamName"]
    @abbreviation = row["abbreviation"]
    @stadium      = row["stadium"]
    @link         = row["link"]

  end

  # def initialize(team_id, franchiseId, teamName, abbreviation, stadium, link)
  #
  #   @team_id      = team_id
  #   @franchiseId  = franchiseId
  #   @teamName     = teamName
  #   @abbreviation = abbreviation
  #   @stadium      = stadium
  #   @link         = link
  #
  # end

end
