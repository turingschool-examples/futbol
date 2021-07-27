class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(stats)
    @team_id = stats[0].to_i
    @franchise_id = stats[1].to_i
    @team_name = stats[2]
    @abbreviation = stats[3]
    @stadium = stats[4]
    @link = stats[5]
  end
end
