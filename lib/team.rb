class Team
  attr_reader :team_id,
              :franchiseId,
              :teamName,
              :abbreviation,
              :stadium,
              :link

  def initialize(row)
    # Have to change team_id back to a string here, then adjust ALL methods and helper methods in Leagueable.
    # Otherwise the spec_harness tests (which expect team_id to return a string) won't work for Teamable in Iteration 4
    @team_id      = row["team_id"]
    @franchiseId  = row["franchiseId"]
    @teamName     = row["teamName"]
    @abbreviation = row["abbreviation"]
    @stadium      = row["stadium"]
    @link         = row["link"]

  end
end
