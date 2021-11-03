require '/spec_helper.rb'
require './lib/stat_tracker.rb'
require './runner.rb'

RSpec.describe StatTracker do

  games = './data/games_dummy.csv'
  teams = './data/teams_dummy.csv'
  game_results = './data/game_results_dummy.csv'
  let(:stat_tracker) {StatTracker.new(games, teams, game_results)}
  let(:games) {CSV.parse(File.read(game_path), headers: true)}
  let(:teams) {CSV.parse(File.read(team_path), headers: true)}
  let(:game_results) {CSV.parse(File.read(game_results), headers: true)}


  it 'exists' do
    expect(stat_tracker).to be_instance_of(StatTracker)
  end

  it 'opens files' do
    expect(stat_tracker.games).to eq('./data/games_dummy.csv')
  end

  it 'it can display the highest total score' do
    expect(highest_total_score).to eq(7)
  end
end
