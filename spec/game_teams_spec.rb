require './lib/game_teams'
require 'csv'
require './lib/stat_tracker'

describe GameTeams do
  before :each do
    @game_team = GameTeams.new({ 
      game_id: "2012030221",
      team_id: "3",
      HoA: "away",
      result: "LOSS",
      settled_in: "OT",
      head_coach: "John Tortorella",
      goals: "2",
      shots: "8",
      tackles: "44",
      pim: "8",
      powerPlayOpportunities: "3",
      powerPlayGoals: "0",
      faceOffWinPercentage: "44.8",
      giveaways: "17",
      takeaways: "7" })
  end

  it 'exists' do
    expect(@game_team).to be_an(GameTeams)
  end

  xit 'to be a hash' do
    expect(GameTeams[0]).to be_instance_of(Hash)
  end

  it 'reads the correct team id' do
    expect(@game_team.team_id).to eq("3")
  end

  it 'reads the correct result' do
    expect(@game_team.result).to eq("LOSS")
  end


end