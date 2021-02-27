require './lib/helper_modules/csv_to_hashable'
require './lib/instances/game_team'

class GameTeamTable
  include CsvToHash
  attr_reader :game_team_data, :teams, :stat_tracker
  def initialize(locations, stat_tracker)
    @game_team_data = from_csv(locations, 'GameTeam')
    @stat_tracker = stat_tracker
  end

  def winningest_coach(season)
    season = @stat_tracker.game_by_season[20132014].map do |season|
      season.game_id
    end
    #wins count / winnings seasons count
    #need to get wins count by each coach

    ids = @game_team_data.map do |gameteam|
      gameteam.game_id
    end

    overlap = season & ids
    require "pry"; binding.pry

  end
end
