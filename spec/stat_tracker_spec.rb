require './spec/spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    # game_path = './data/games.csv'
    # team_path = './data/teams.csv'
    # game_teams_path = './data/game_teams.csv'

    # @locations = {
    #   games: game_path,
    #   teams: team_path,
    #   game_teams: game_teams_path
    # }

    # Just the one small file for now to test, idk what this exactly is
    gtf_path = './data/game_team_fixture.csv'
    @locations = {gtf: gtf_path}

    @stats = StatTracker.from_csv(@locations)
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
end