class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(team_info)
    @team_id = team_info[0]
    @franchise_id = team_info[1]
    @team_name = team_info[2]
    @abbreviation = team_info[3]
    @stadium = team_info[4]
    @link = team_info[5]
  end


end
