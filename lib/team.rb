class Team
  attr_reader :team_id, :franchise_id, :team_name,
              :abbreviation, :stadium, :link,
              :manager, :average_goals, :avg_goals_home,
              :avg_goals_visitor, :best_season, :worst_season,
              :avg_win_pct, :favorite_opponent, :rival

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
    @best_season = get_best_season(@team_id)
    @worst_season = get_worst_season(@team_id)
    @avg_win_pct = get_average_win_percentage(@team_id)
    @favorite_opponent = get_favorite_opponent(@team_id)
    @rival = get_rival(@team_id)
  end

  def team_average_goals(team_id)
    @manager.average_number_of_goals_scored_by_team(team_id)
  end

  def average_goals_by_type(team_id, home_away)
    @manager.average_number_of_goals_scored_by_team_by_type(team_id, home_away)
  end

  def get_best_season(team_id)
    @manager.get_best_season(team_id)
  end

  def get_worst_season(team_id)
    @manager.get_worst_season(team_id)
  end

  def get_average_win_percentage(team_id)
    @manager.get_average_win_percentage(team_id)
  end

  def get_favorite_opponent(team_id)
    @manager.get_favorite_opponent(team_id)
  end

  def get_rival(team_id)
    @manager.get_rival(team_id)
  end
end
