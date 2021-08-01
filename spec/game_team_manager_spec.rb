require 'spec_helper'

RSpec.describe GameTeamManager do
  before(:each) do
    game_path = './data/season_game_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/season_game_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @game_team_manager = GameTeamManager.new(locations)
  end

  it "exists" do
    expect(@game_team_manager).to be_a(GameTeamManager)
  end

  it "is an array" do
    expect(@game_team_manager.game_teams).to be_an(Array)
  end

  it 'can find by game id' do
    expect(@game_team_manager.by_game_id('2012030221')).to be_an(Array)
    expect(@game_team_manager.by_game_id('2012030221').count).to eq(2)
    expect(@game_team_manager.by_game_id('2012030221')[0]).to be_a(GameTeam)
  end

  it 'can find winning coach' do
    expect(@game_team_manager.winning_coach('2012030221')).to eq('Claude Julien')
  end

  it 'can find winning coaches' do
    season_game_ids = ['2012030221',
    '2012030222',
    '2012030223',
    '2012030224',
    '2012030225',
    '2012030311',
    '2012030312',
    '2012030313',
    '2012030314',
    '2012030231']
    results = ["Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien", "Joel Quenneville"]
    expect(@game_team_manager.winning_coaches(season_game_ids)).to eq(results)
  end
end
