class Team
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  def initialize(params)
    @team_id      = params["team_id"]
    @franchiseid  = params["franchiseId"]
    @teamname     = params["teamName"]
    @abbreviation = params["abbreviation"]
    @stadium      = params["Stadium"]
    @link         = params["link"]
  end
end
