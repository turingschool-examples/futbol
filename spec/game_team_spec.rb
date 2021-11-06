require "rspec"
require "./lib/game_team"

describe GameTeam do
  it 'exists' do
    expect(game_team).to be_an_instance_of(GameTeam)
  end

  it 'attributes' do
    expect(game_team.game_id).to eq()
  end

  it 'can group game IDs' 
end
