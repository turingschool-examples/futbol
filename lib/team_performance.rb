require_relative 'helper_class'

class TeamPerformance
  @@games = []
  attr_reader :game_id,
              :season,
              :away_team_id,
              :away_team_goals,
              :away_team_name,
              :home_team_id,
              :home_team_goals,
              :home_team_name

  def initialize(test_game_file)
    @game_id = test_game_file[:game_id]
    # @season = test_game_file[:season]
    # @away_team_id = test_game_file[:away_team_id]
    @home_team_name = test_game_file[:home_team_name]
    @away_team_name = test_game_file[:away_team_name]
    @away_team_goals = test_game_file[:away_goals].to_i
    @home_team_id = test_game_file[:home_team_id]
    @home_team_goals = test_game_file[:home_goals].to_i
    @@games << self
  end

  private
  
  def self.games
    @@games
  end
end