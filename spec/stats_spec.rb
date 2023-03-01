require 'spec_helper'

RSpec.describe Stats do
  before(:each) do
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @files = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stats = Stats.new(@files)
  end

  describe '#initialize' do
    it 'exists' do
     expect(@stats).to be_a(Stats)
    end

    it 'has teams' do
      expect(@stats.teams.first).to be_a(Teams)
    end

    it 'has team attributes' do
      expect(@stats.teams.first.team_name).to eq('Atlanta United')
      expect(@stats.teams.first.team_id).to eq('1')
    end
  end
end