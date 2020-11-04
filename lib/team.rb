class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :link,
              :team_data

  def initialize(data)
    @team_id = data["team_id"]
    @franchise_id = data["franchiseId"]
    @team_name = data["teamName"]
    @abbreviation = data["abbreviation"]
    @link = data["link"]
  end

  def team_info
    {
      "team_id" => team_id,
      "franchise_id" => franchise_id,
      "team_name" => team_name,
      "abbreviation" => abbreviation,
      "link" => link
    }
  end
end
