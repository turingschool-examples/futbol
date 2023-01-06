require './spec/spec_helper'

describe Game_teams do
  before do
    game_teams_path = './data/game_teams_sample.csv'
    @game_teams = Game_teams.create_game_teams(game_teams_path)
    @game_team = @game_teams[0]
  end

  
end