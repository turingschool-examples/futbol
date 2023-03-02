require 'spec_helper'

RSpec.describe GameTeam do
  before(:each) do 
    @game_team = GameTeam.new(
      {
        game_id: 2012030221,
        team_id: '3',
        home_or_away: 'away',
        result: 'LOSS',
        head_coach: 'John Tortorella',
        goals: 2,
        shots: 8,
        tackles: 44
      }
    )
  end

  it 'exists' do
    expect(@game_team).to be_a(GameTeam)
  end

  it 'has attributes' do
    expect(@game_team.game_id).to eq(2012030221)
    expect(@game_team.team_id).to eq('3')
    expect(@game_team.home_or_away).to eq('away')
    expect(@game_team.result).to eq('LOSS')
    expect(@game_team.head_coach).to eq('John Tortorella')
    expect(@game_team.goals).to eq(2)
    expect(@game_team.shots).to eq(8)
    expect(@game_team.tackles).to eq(44)
  end
end