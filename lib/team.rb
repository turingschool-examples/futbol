class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :link,
              :team_data


  def initialize(data)
    @team_id = data["team_id"]
    @franchise_id = data["franchise_id"]
    @team_name = data["team_name"]
    @abbreviation = data["abbreviation"]
    @link = data["link"]
    @team_data = data
  end
end
