require 'simplecov'
SimpleCov.start

require './lib/stat_tracker'

RSpec.describe StatTracker do
  let!(:game_path) { './data/games.csv' }
  let!(:team_path) { './data/teams.csv' }
  let!(:game_teams_path) { './data/game_teams.csv' }
  
  let!(:locations) { {games: game_path, teams: team_path, game_teams: game_teams_path } }

  let!(:stat_tracker) { StatTracker.from_csv(locations) }
  context 'stat_tracker instantiates' do
    it 'should have a class' do
      expect(stat_tracker).to be_a StatTracker
    end

    it 'self method should be an instance of the class' do
      expect(StatTracker.from_csv(locations)).to be_a StatTracker
    end
  end

  context 'csv_open method' do 
    let(:games_data) {CSV.open locations[:games], headers: true, header_converters: :symbol}
    let(:teams_data) {CSV.open locations[:teams], headers: true, header_converters: :symbol}
    let(:game_teams_data) {CSV.open locations[:game_teams], headers: true, header_converters: :symbol}
    
    xit 'reads csv data' do
      expect(stat_tracker.games).to eq(games_data)
      expect(stat_tracker.teams).to eq(teams_data)
      expect(stat_tracker.game_teams).to eq(game_teams_data)
    end
   end
end