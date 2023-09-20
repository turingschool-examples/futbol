require './spec/spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    ## LOCATING CSV FILES
    game_team_path = './data/game_team_fixture.csv'
    games_path = './data/games_fixture.csv'
    teams_path = './data/teams_fixture.csv'
    @locations = {  game_team_f: game_team_path, 
                    games_f: games_path, 
                    teams_f: teams_path,
                  }

    @stats = StatTracker.from_csv(@locations)
    # @stats.create_games
  end
  
  describe '#initialize' do
    it 'exists' do
      expect(@stats).to be_instance_of(StatTracker)
    end
    
    it 'has attributes' do
      expect(@stats.all_data.values.all? { |file| File.exist?(file) } ).to be true
    end
  end
  
  describe '::from_csv' do
    it 'Gets data and makes instance' do
      expect(StatTracker.from_csv(@locations)).to be_instance_of(StatTracker)
    end
  end
  
  describe '#GameStatistics' do
    it 'gets highest total score' do
      @stats.highest_total_score
      expect(@stats.highest_total_score).to eq(7)
    end

    it 'gets lowest total score' do
      @stats.lowest_total_score
      # require 'pry'; binding.pry
      expect(@stats.lowest_total_score).to eq(1)
    end
  end
end