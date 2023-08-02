require_relative 'helper_class'

class Season
  @@seasons = []
  attr_reader :season,
              :game_id,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(data)
    @season = data[:season]
    @game_id = data[:game_id]
    @away_team_id = data[:away_team_id]
    @home_team_id = data[:home_team_id]
    @away_goals = data[:away_goals]
    @home_goals = data[:home_goals]
    @@seasons << self
  end

  def self.seasons
    @@seasons
  end
end