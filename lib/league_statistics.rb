class LeagueStatistics
  include DataLoadable

  def initialize(data)
    @games = load_data(data[:games], Game)
    @teams = load_data(data[:teams], Team)
    @game_teams = load_data(data[:game_teams], GameTeam)
  end

  def count_of_teams
    @teams.count
    # Description - Total number of teams in the data.
    # Return Value - Integer
  end

  def best_offense
    # Description - Name of the team with the highest average number of goals scored per game across all seasons.
    # Return Value - String
  end

  def worst_offense
    # Description - Name of the team with the lowest average number of goals scored per game across all seasons.
    # Return Value - String
  end

  def highest_scoring_visitor
    # Description - Name of the team with the highest average score per game across all seasons when they are away.
    # Return Value - String
  end

  def highest_scoring_home_team
    # Description - Name of the team with the highest average score per game across all seasons when they are home.
    # Return Value - String
  end

  def lowest_scoring_visitor
    # Description - Name of the team with the lowest average score per game across all seasons when they are a visitor.
    # Return Value - String
  end

  def lowest_scoring_home_team
    # Description - Name of the team with the lowest average score per game across all seasons when they are at home.
    # Return Value - String
  end

end
