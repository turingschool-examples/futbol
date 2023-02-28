require_relative '../spec/spec_helper'

class StatTracker

  
  def from_csv(locations)
    @games = processed_game_data(locations[:games])
    @teams = processed_teams_data(locations[:teams])
    @game_teams = processed_game_teams_data(locations[:game_teams])
  end

  
end