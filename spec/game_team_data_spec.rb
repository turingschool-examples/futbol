require 'spec_helper'
describe GameTeamData do
  it 'can import team data' do
    dataset = GameTeamData.new
    dataset.add_game_team
    expect(dataset.game_teams[0].game_id).to eq("2012030221")
  end
end