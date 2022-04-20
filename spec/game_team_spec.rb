require './required_files'

describe GameTeam do

  before(:each) do
    @game_team1 = GameTeam.new({game_id: "2012030221", team_id: "3", hoa: "away", result: "LOSS", settled_in: "OT", head_coach: "John Tortorella", goals: "2", shots: "8", tackles: "44", pim: "8", powerplayopportunities: "3", powerplaygoals: "0", faceoffwinpercentage: "44.8", giveaways: "17", takeaways: "7"})
  end

  it 'exists' do
    expect(@game_team1).to be_a(GameTeam)
  end

  it 'has readable attributes' do
    expect(@game_team1.game_id).to eq("2012030221")
    expect(@game_team1.team_id).to eq("3")
    expect(@game_team1.hoa).to eq("away")
    expect(@game_team1.result).to eq("LOSS")
    expect(@game_team1.settled_in).to eq("OT")
    expect(@game_team1.head_coach).to eq("John Tortorella")
    expect(@game_team1.goals).to eq("2")
    expect(@game_team1.shots).to eq("8")
    expect(@game_team1.tackles).to eq("44")
    expect(@game_team1.pim).to eq("8")
    expect(@game_team1.power_play_opportunities).to eq("3")
    expect(@game_team1.power_play_goals).to eq("0")
    expect(@game_team1.face_off_win_percentage).to eq("44.8")
    expect(@game_team1.giveaways).to eq("17")
    expect(@game_team1.takeaways).to eq("7")
  end

end
