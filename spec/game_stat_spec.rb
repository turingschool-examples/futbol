require 'spec_helper'

RSpec.configure do |config| 
  config.formatter = :documentation 
end



RSpec.describe Game do 
  before(:each) do 
    game_path = './data/dummy_games.csv'
    team_path = './data/dummy_teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    
  end
end

