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
end
