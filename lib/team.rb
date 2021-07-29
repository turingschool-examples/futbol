class Team
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  def initialize(params)
    @team_id      = params["team_id"]
    @franchiseid  = params["franchiseid"]
    @teamname     = params["teamname"]
    @abbreviation = params["abbreviation"]
    @stadium      = params["stadium"]
    @link         = params["link"]
  end
end
