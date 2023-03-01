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
  end
end