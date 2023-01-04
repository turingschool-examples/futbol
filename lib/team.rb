class Team 
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link 

  def initialize(info)
    @team_id = info[:team_id]
    @franchise_id = info[:franchise_id]
    @team_name = info[:team_name]
    @abbreviation = info[:abbreviation]
    @stadium = info[:stadium]
    @link = info[:link]
  end
end