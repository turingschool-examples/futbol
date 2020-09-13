class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link,
              :manager,
              :average_goals,
              :avg_goals_home,
              :avg_goals_visitor

  def initialize(data, manager)
    @team_id = data["team_id"]
    @franchise_id = data["franchiseId"]
    @team_name = data["teamName"]
    @abbreviation = data["abbreviation"]
    @stadium = data["Stadium"]
    @link = data["link"]
    @manager = manager
    @average_goals = team_average_goals(@team_id)
    @avg_goals_visitor = average_goals_by_type(@team_id, 'away')
    @avg_goals_home = average_goals_by_type(@team_id, 'home')
  end

  def team_average_goals(team_id)
    @manager.average_number_of_goals_scored_by_team(team_id)
  end

  def average_goals_by_type(team_id, home_away)
    @manager.average_number_of_goals_scored_by_team_by_type(team_id, home_away)
  end
end
