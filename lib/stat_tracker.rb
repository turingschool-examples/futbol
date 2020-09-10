require 'csv'
require_relative 'csv_file'
require_relative 'game_statistics'
require_relative 'game_team'
require_relative 'game'
require_relative 'team'
require_relative 'team_statistics'
require_relative 'season_statistics'

class StatTracker
  include Csv, GameStatistics, TeamStatistics, SeasonStatistics
  attr_reader   :game_table,
                :team_table,
                :game_team_table,
                :locations
  def initialize(locations = {})
    @locations = locations
    @game_table = {}
    @team_table = {}
    @game_team_table = []
    csv_game_files
    csv_team_files
    csv_game_team_files
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end
