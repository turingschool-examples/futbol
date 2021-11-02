require './lib/stat_tracker'

class GamesData < StatTracker

  attr_reader :game_data

  def initialize(current_stat_tracker)
    @game_data = current_stat_tracker.games
    # @game_id = nil
    # @season = nil
    # @type = nil
    # @data_time = nil
    # away_team_id = nil
    # home_team_id = nil
    # away_goals = nil
    # home_goals = nil
    # venue_link = nil
  end
end
