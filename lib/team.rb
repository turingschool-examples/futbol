class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link
  def initialize(data)
    @team_id = data[:team_id].to_s
    @franchise_id = data[:franchiseId].to_s
    @team_name = data[:team_name].to_s
    @abbreviation = data[:abbreviation].to_s
    @stadium = data[:stadium].to_s
    @link = data[:link].to_s
  end

end
