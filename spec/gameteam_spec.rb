require './spec/spec_helper'

RSpec.describe GameTeam do
  before(:each) do
    gameteam_data = { game_id: 2_012_030_221,
    team_id: 3,
    hoa: "away",
    result: "LOSS",
    head_coach: "John Tortorella",
    goals: 2,
    shots: 8,
    tackles: 44
    }
    @gameteam1 = GameTeam.new(gameteam_data)
  end

  it 'exists' do
    expect(@gameteam1).to be_an_instance_of GameTeam
  end

  it 'has attributes that can be read' do
    expect(@gameteam1.team_id).to eq 3
    expect(@gameteam1.hoa).to eq "away"
    expect(@gameteam1.result).to eq "LOSS"
    expect(@gameteam1.head_coach).to eq "John Tortorella"
    expect(@gameteam1.goals).to eq 2
    expect(@gameteam1.shots).to eq 8
    expect(@gameteam1.tackles).to eq 44
  end

  it "can create GameTeam objects using the create_from_csv method" do
    new_game_teams = GameTeam.create_from_csv("./data/game_teams_dummy.csv")
    starting_game_team = new_game_teams.first
    expect(starting_game_team.game_id).to eq(2_012_030_221)
    expect(starting_game_team.team_id).to eq(3)
    expect(starting_game_team.hoa).to eq("away")
    expect(starting_game_team.result).to eq("LOSS")
    expect(starting_game_team.head_coach).to eq('John Tortorella')
    expect(starting_game_team.goals).to eq(2)
    expect(starting_game_team.shots).to eq(8)
    expect(starting_game_team.tackles).to eq(44)
  end

end