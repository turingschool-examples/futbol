class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link,
              :manager,
              :average_goals

  def initialize(data, manager)
    @team_id = data["team_id"]
    @franchise_id = data["franchiseId"]
    @team_name = data["teamName"]
    @abbreviation = data["abbreviation"]
    @stadium = data["Stadium"]
    @link = data["link"]
    @manager = manager
    @average_goals = team_average_goals(@team_id)
  end

  def team_average_goals(team_id)
    @manager.average_number_of_goals_scored_by_team(team_id)
  end
end
