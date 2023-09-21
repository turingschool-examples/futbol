class Team
  attr_reader :team_id,
              :franchise_id,
              :name,
              :abbreviation,
              :stadium,
              :link
  def initialize(team_info)
    @team_id = team_info[:team_id].to_i
    @franchise_id = team_info[:franchiseid].to_i
    @name = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
  end
end