require 'spec_helper'
require_relative '../lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

  
    @data_set = StatTracker.from_csv(@locations)
    
  end
  describe ".from_csv" do
    it 'is instance of class' do
      expect(@data_set).to be_an_instance_of(StatTracker)
    end
  end
end


