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

  describe '#initialize Teams' do
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
  describe '#initializes Games' do
    it 'exists' do
      expect(@stats.games.first).to be_a(Games)
    end

    it 'game has attributes' do
      expect(@stats.games.first.game_id).to eq('2012030221')
      expect(@stats.games.first.season_year).to eq('20122013')
      expect(@stats.games.first.season_type).to eq('Postseason')
      expect(@stats.games.first.away_team_id).to eq('3')
      expect(@stats.games.first.home_team_id).to eq('6')
      expect(@stats.games.first.home_goals).to eq('3')
      expect(@stats.games.first.away_goals).to eq('2')
      expect(@stats.games.first.total_score).to eq(5)
    end
  end
end