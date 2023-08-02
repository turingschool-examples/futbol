require_relative 'helper_class'

class Game
  attr_reader :game_id,
              :season,
              :away_team_id,
              :away_team_goals,
              :home_team_id,
              :home_team_goals

  def initialize(game)
    @game_id = game_file[:game_id]
    @season = game_file[:season]
    @away_team_id = game_file[:away_team_id]
    @away_team_goals = game_file[:away_team_goals]
    @home_team_id = game_file[:home_team_id]
    @home_team_goals = game_file[:home_team_goals]
  end
end