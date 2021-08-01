require 'spec_helper'

RSpec.describe GameTeamManager do
  before(:each) do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_sample.csv'

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


  # it 'can find game team by game and team id' do
  #   game =  @game_team_manager.by_team_and_game_id('3', '2012030221')
  #   expect(game.game_id).to eq('2012030221')
  #
  # end


end
