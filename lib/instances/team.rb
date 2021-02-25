
class Team 
  attr_reader :team_id,
              :franchiseId,
              :teamName,
              :abbreviation,
              :Stadium,
              :link
  def initialize(data)
    @team_id= team_id
    @franchiseId =franchiseId
    @teamname = teamName
    @abbreviation = abbreviation
    @stadium = stadium
    @link = link
  end
end