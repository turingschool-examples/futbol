require './lib/stat_tracker'

class LeagueStats < StatTracker
  attr_reader :games

  def initialize(games)
    @games = games
  end

  def count_of_teams
    # Use teams.csv to count up all possible teams
  end

  def best_offense
    # Find team with highest goal average in all seasons.
  end

  def worst_offense
    # Find team with lowest goal average in all seasons
  end

  def highest_scoring_visitor
    # Find team with highest scores while away
  end

  def highest_scoring_home_team
    # Find team with highest scores while home
  end

  def lowest_scoring_visitor
    # Find team with lowest scores while away
  end

  def lowest_scoring_home_team
    # Find team with lowest scores while home
  end
end
