require './spec_helper'

RSpec.describe GameTeam do
  before(:each) do
    sample_data = {
      game_id: "2012030221",
      team_id: "3",
      hoa: "away",
      result: "LOSS",
      settled_in: "OT",
      head_coach: "John Tortorella",
      goals: 2,
      shots: 8,
      tackles: 44,
      pim: 8,
      powerplayopportunities: 3,
      powerplaygoals: 0,
      faceoffwinpercentage: 44.8,
      giveaways: 17,
      takeaways: 7
    }

    @game_team = GameTeam.new(sample_data)
  end

  it 'exists' do
    expect(@game_team).to be_a(GameTeam)
  end

  it 'has a game_id' do
    expect(@game_team.game_id).to eq("2012030221")
  end

  it 'has a team_id' do
    expect(@game_team.team_id).to eq("3")
  end

  it 'has a Home or Away' do
    expect(@game_team.hoa).to eq("away")
  end

  it 'has a result' do
    expect(@game_team.result).to eq("LOSS")
  end

  it 'has a settled in' do
    expect(@game_team.settled_in).to eq("OT")
  end

  it 'has a head coach' do
    expect(@game_team.head_coach).to eq("John Tortorella")
  end

  it 'has goals' do
    expect(@game_team.goals).to eq(2)
  end

  it 'has shots'do
    expect(@game_team.shots).to eq(8)
  end

  it 'has tackles' do
    expect(@game_team.tackles).to eq(44)
  end

  it 'has pim' do
    expect(@game_team.pim).to eq(8)
  end

  it 'has power play opportunities' do
    expect(@game_team.power_play_opportunities).to eq(3)
  end

  it 'has power play goals' do
    expect(@game_team.power_play_goals).to eq(0)
  end

  it 'has face off win percentage' do
    expect(@game_team.face_off_win_percentage).to eq(44.8)
  end

  it 'has giveaways' do
    expect(@game_team.giveaways).to eq(17)
  end

  it 'has takeaways' do
    expect(@game_team.takeaways).to eq(7)
  end
end