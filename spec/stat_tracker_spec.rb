require '/spec_helper.rb'
require './lib/stat_tracker.rb'
require './runner.rb'

RSpec.describe StatTracker do

  game_path = './data/games_dummy.csv'
  team_path = './data/teams_dummy.csv'
  game_results_path = './data/game_results_dummy.csv'
  let(:games) {CSV.parse(File.read(game_path), headers: true)}
  let(:teams) {CSV.parse(File.read(team_path), headers: true)}
  let(:game_results) {CSV.parse(File.read(game_results_path), headers: true)}
  let(:stat_tracker) {StatTracker.new(games, teams, game_results)}


  it 'exists' do
    expect(stat_tracker).to be_instance_of(StatTracker)
  end

  xit 'opens files' do
    expect(stat_tracker.games).to eq('./data/games_dummy.csv')
  end

  it 'it can display the highest total score' do
    expect(stat_tracker.highest_total_score).to eq(5)
  end
end
