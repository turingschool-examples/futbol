class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium

  def initialize(team_id, franchise_id, team_name, abbreviation, stadium)
    @team_id = team_id
    @franchise_id = franchise_id
    @team_name = team_name
    @abbreviation = abbreviation
    @stadium = stadium
  end
end

#stat tracker is going to be the one to collect all the
#class of game shouldn't know anything about the class of teams