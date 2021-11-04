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

  it 'can display the highest total score' do
    expect(stat_tracker.highest_total_score).to eq(5)
  end

  it 'it can display lowest total score' do
    expect(stat_tracker.lowest_total_score).to eq(3)
  end

  it 'it can display total wins by home team as percentage' do
    expect(stat_tracker.percentage_home_wins).to eq(60.00)
  end

  xit 'can find the percentage of games that a visitor has won' do
    expect(stat_tracker.percentage_visitor_wins).to eq(40.00)
  end

  xit 'can find the percentage of games that resulted in a tie' do
    expect(stat_tracker.percentage_ties).to eq(0.00)
  end

  it 'can sort the number of games attributed to each season' do
    expect(stat_tracker.count_of_games_by_season).to be_a(Hash)
    expect(stat_tracker.count_of_games_by_season).to include('20122013' => 10)
    #may need to change dummy data to test more key/value pairs
  end

  it 'can calculate average goals per game across seasons' do
    expect(stat_tracker.averagee_goals_per_game),to eq(3.70)
  end

  it 'can organize average goals per game by season' do
    expect(stat_tracker.average_goals_by_season).to be_a(Hash)
    expect(stat_tracker.average_goals_by_season).to include('20122013' => 3.70)
  end
end
