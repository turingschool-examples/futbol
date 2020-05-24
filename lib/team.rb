class Team

# CSV.read(./data/teams.csv)
attr_reader :id,
            :franchiseid,
            :teamname,
            :abbreviation,
            :stadium,
            :link

def initialize(info)
  @id           = info["team_id"]
  @franchise_id = info["franchiseid"]
  @name         = info["teamname"]
  @abbreviation = info["abbreviation"]
  @stadium      = info["stadium"]
  @link         = info["link"]
end

@@all_teams= []

end
