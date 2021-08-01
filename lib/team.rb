class Team
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  def initialize(params)
    @team_id      = params["team_id"]
    @franchiseid  = params["franchiseId"]#Not used within code. put it down
    @teamname     = params["teamName"]
    @abbreviation = params["abbreviation"]
    @stadium      = params["Stadium"] #Not used within existing methods can be put down
    @link         = params["link"]
  end
end
