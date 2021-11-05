require "./lib/league.rb"
require './lib/stat_tracker.rb'

RSpec.describe League do
  game_path = './data/games_dummy.csv'
  team_path = './data/teams_dummy.csv'
  game_teams_path = './data/game_teams_dummy.csv'
  let(:games) {CSV.parse(File.read(game_path), headers: true)}
  let(:teams) {CSV.parse(File.read(team_path), headers: true)}
  let(:game_teams) {CSV.parse(File.read(game_teams_path), headers: true)}

  it 'exists' do
    league = League.new(games, teams, game_teams)
    expect(league).to be_instance_of(League)
  end
end
