require 'spec_helper'

RSpec.describe RawStats do
  before(:each) do
    data = {
      teams: './data/teams.csv',
      games: './fixtures/games_sample.csv',
      game_teams: './fixtures/game_teams_sample.csv'
    }
    @stats = RawStats.new(data)
  end

  it 'exists' do
    expect(@stats).to be_a(RawStats)
  end

  it 'has an array of Team objects' do
    expect(@stats.teams).to be_a(Array)
    expect(@stats.teams[0]).to be_a(Team)
  end

  it 'has an array of Game objects' do
    expect(@stats.games).to be_a(Array)
    expect(@stats.games[0]).to be_a(Game)
  end

  it 'has an array of GameTeam objects' do
    expect(@stats.game_teams).to be_a(Array)
    expect(@stats.game_teams[0]).to be_a(GameTeam)
  end
end