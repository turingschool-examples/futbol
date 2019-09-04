class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(info)
    @team_id = info[0]
    @franchise_id = info[1]
    @team_name = info[2]
    @abbreviation = info[3]
    @stadium = info[4]
    @link = info[5]
  end
end
