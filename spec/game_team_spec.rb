require 'spec_helper'
require './lib/game_team/'

RSpec.describe GameTeam do
    before :all do
    @game_team_hash = {
        game_id: '2012030221',
        team_id: '6',
        HoA: 'home',
        result: 'WIN',
        settled_in: 'OT',
        head_coach: 'Claude Julien',
        goals: '3',
        shots: '12',
        tackles: '51',
        pim: '6',
        powerPlayOpportunities: '4',
        powerPlayGoals: '1',
        faceOffWinPercentage: '55.2',
        giveaways: '4',
        takeaways: '5'
    }
        @game_team = GameTeam.new(@game_team_hash)
    end

  it 'exists' do
    expect(@game_team).to be_a GameTeam
  end

  it 'initializes with attributes' do
    expect(@game_team.game_id). to eq('2012030221')
    expect(@game_team.team_id).to eq('6')
    expect(@game_team.HoA).to eq('home')
    expect(@game_team.result).to eq('WIN')
    expect(@game_team.settled_in).to eq('OT')
    expect(@game_team.head_coach).to eq('Claude Julien')
    expect(@game_team.goals).to eq('3')
    expect(@game_team.shots).to eq('12')
    expect(@game_team.tackles).to eq('51')
    expect(@game_team.pim).to eq('6')
    expect(@game_team.powerPlayOpportunities).to eq('4')
    expect(@game_team.powerPlayGoals).to eq('1')
    expect(@game_team.faceOffWinPercentage).to eq('55.2')
    expect(@game_team.giveaways).to eq('4')
    expect(@game_team.takeaways).to eq('5')
  end
end 