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

    #Note: I  added a string to int converter to my iteration_4 methods for now.
    #It just converts the method input to an int just to make sure our methods pass the tests.
    #BB
    @team_id      = row["team_id"].to_i
    @franchiseId  = row["franchiseId"]
    @teamName     = row["teamName"]
    @abbreviation = row["abbreviation"]
    @stadium      = row["stadium"]
    @link         = row["link"]

  end
end
