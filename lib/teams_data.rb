require './lib/stat_tracker'
class TeamsData < StatTracker

  attr_reader :teamData
  def initialize(current_stat_tracker)
    @teamData = current_stat_tracker.teams
    #
    # @team_id = @teams["team_id"]
    # @franchise_id = @teams["franchise_id"]
    # @team_name = @teams["teamName"]
    # @abbreviation = @teams["abbreviation"]
    # @stadium = @teams["Stadium"]
    # @link = @teams["link"]
  end

  def team_info

  end

  def best_season

  end

  def worst_season

  end

  def average_win_percentage

  end

  def most_goals_scored

  end

  def fewest_goals_scored

  end

  def favorite_opponent

  end

  def rival

  end
end
