require './spec/spec_helper'


RSpec.describe StatTracker do

  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    
    @stat_tracker = StatTracker.from_csv(locations)
require 'pry'; binding.pry
  end

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
  end



end

