class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :link,
              :team_data,
              :parent

  def initialize(data, parent)
    @team_id = data["team_id"]
    @franchise_id = data["franchise_id"]
    @team_name = data["team_name"]
    @abbreviation = data["abbreviation"]
    @link = data["link"]
    @parent = parent
  end
end
