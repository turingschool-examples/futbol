require "./lib/csv_data"
require './lib/games'
require './lib/teams'
require './lib/game_teams'
require './lib/season_statistics'
class StatTracker

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    csv_data = CSVData.new(locations)
  #  @team_statistics = csv_data.team_statistics
    @season_statistics = csv_data.season_statistics
  end

  def winningest_coach(season)
    @season_statistics.winningest_coach(season)
  end

  def worst_coach(season)
    @season_statistics.worst_coach(season)
  end

  def most_accurate_team(seasonID)
    @season_statistics.most_accurate_team(seasonID)
  end

  def least_accurate_team(seasonID)
    @season_statistics.least_accurate_team(seasonID)
  end

  def fewest_tackles(seasonID)
    @season_statistics.fewest_tackles(seasonID)
  end

  def most_tackles(seasonID)
    @season_statistics.most_tackles(seasonID)
  end

end#class
