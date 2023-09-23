class Team
  def initialize(game_team_data, game_data, team_data)
    @game_team_data = game_team_data
    @game_data = game_data
    @team_data = team_data
  end

  # this method does not work because @team_data is not importing franchise_id for any teams
  def team_info(team_id)
    team_info = @team_data.find do |team|
      team[:team_id] == team_id
    end
    key_map = {
      team_id: "team_id", 
      team_name: "team_name", 
      franchise_id: "franchise_id",
      abbreviation: "abbreviation",
      link: "link"
    }
    team_info.transform_keys! { |k| key_map[k] }
  end
end