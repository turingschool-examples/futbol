class Team
  attr_reader :id,
              :franchiseId,
              :name,
              :abbr,
              :stadium,
              :link

  def initialize(team_info)
    @id = team_info[:team_id].to_i
    @franchiseId = team_info[:franchiseId].to_i
    @name = team_info[:teamName]
    @abbr = team_info[:abbreviation]
    @stadium = team_info[:Stadium]
    @link = team_info[:link]
  end

end
