require_relative 'helper_class'

class League
  @@games = []
  attr_reader :away_team_id,
              :away_team_goals,
              :home_team_id,
              :home_team_goals

  def initialize(test_game_file)
    @away_team_id = test_game_file[:away_team_id]
    @away_team_goals = test_game_file[:away_goals].to_i
    @home_team_id = test_game_file[:home_team_id]
    @home_team_goals = test_game_file[:home_goals].to_i
    @@games << self
  end

  # private

  def self.games
    @@games
  end
end