require './lib/stat_tracker'
class TeamsData < StatTracker

  attr_reader :teamData
  def initialize(current_stat_tracker)
    @teamData = current_stat_tracker.teams
    #

  end

  def team_info(team_id)
    @team_id = @teams["team_id"]
    @franchise_id = @teams["franchise_id"]
    @team_name = @teams["teamName"]
    @abbreviation = @teams["abbreviation"]
    @link = @teams["link"]


  end

  def best_season(team_id)

  end

  def worst_season(team_id)

  end

  def average_win_percentage(team_id)

  end

  def most_goals_scored(team_id)

  end

  def fewest_goals_scored(team_id)

  end

  def favorite_opponent(team_id)

  end

  def rival(team_id)

  end
end
