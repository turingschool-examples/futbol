require "./lib/league.rb"
require './lib/stat_tracker.rb'

RSpec.describe League do
  game_path = './data/games_dummy.csv'
  team_path = './data/teams_dummy.csv'
  game_teams_path = './data/game_teams_dummy.csv'
  let(:games) {CSV.parse(File.read(game_path), headers: true).map {|row| Game.new(row)}}
  let(:teams) {CSV.parse(File.read(team_path), headers: true).map {|row| Team.new(row)}}
  let(:game_teams) {CSV.parse(File.read(game_teams_path), headers: true).map {|row| GameTeam.new(row)}}
  let(:data) {{games: games, teams: teams, game_teams: game_teams}}

  let(:league) {League.new(data)}

  it 'exists' do
    league = League.new(data)
    expect(league).to be_instance_of(League)
  end

  it 'has attributes' do

    expect(league.games).to be_a(Array)
    expect(league.games).to include(Game)
    expect(league.teams).to be_a(Array)
    expect(league.teams).to include(Team)
    expect(league.game_teams).to be_a(Array)
    expect(league.game_teams).to include(GameTeam)
  end

  it 'can count total number of teams' do
    #
    expect(league.count_of_teams).to eq(10)
  end
end



#require "pry"; binding.pry
