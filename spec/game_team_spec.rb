require './lib/game_team'

RSpec.describe GameTeam do

  it 'exists' do
    info = {game_id:"2012030221", team_id:"3", hoa:"away", result:"LOSS", settled_in:"OT", head_coach:"John Tortorella", goals:"2", shots:"8", tackles:"44", pim:"8", powerplayopportunities:"3", powerplaygoals:"0", faceoffwinpercentage:"44.8", giveaways:"17", takeaways:"7"}
    game_team = GameTeam.new(info)
    expect(game_team).to be_a(GameTeam)
  end

  it 'game_team has data' do
    info = {game_id:"2012030221", team_id:"3", hoa:"away", result:"LOSS", settled_in:"OT", head_coach:"John Tortorella", goals:"2", shots:"8", tackles:"44", pim:"8", powerplayopportunities:"3", powerplaygoals:"0", faceoffwinpercentage:"44.8", giveaways:"17", takeaways:"7"}
    game_team = GameTeam.new(info)
    expect(game_team.game_id).to eq(2012030221)
    expect(game_team.hoa).to eq("away")
    expect(game_team.tackles).to eq(44)
    expect(game_team.faceoff_win_percentage).to eq(44.8)
  end
end
