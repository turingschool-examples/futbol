require_relative 'helper_class'

class Season
  @@seasons = []
  attr_reader :season,
              :game_id,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(season, data)
    @season = season
    @game_id = data.map { |row| row[:game_id] }
    @away_team_id = data.map { |row| row[:away_team_id] }
    @home_team_id = data.map { |row| row[:home_team_id] }
    @away_goals = data.map { |row| row[:away_goals] }
    @home_goals = data.map { |row| row[:home_goals] }
    @@seasons << self
  end

  def self.seasons
    @@seasons
  end
end