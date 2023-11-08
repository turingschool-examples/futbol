require 'CSV'
require './lib/game_teams'


RSpec.describe GameTeams do
  it 'can correctly create new Game class instance' do
    game_teams = GameTeams.new

    expect(game_teams.array.length).to eq(14883)

    game2012030221 = game_teams.array.find { |game| game.game_id == 2012030221}

    expect(game2012030221.game_id).to eq(2012030221)
    expect(game2012030221.team_id).to eq(3)
    expect(game2012030221.hoa).to eq("away")
    expect(game2012030221.result).to eq("LOSS")
    expect(game2012030221.settled_in).to eq("OT")
    expect(game2012030221.head_coach).to eq("John Tortorella")
    expect(game2012030221.goals).to eq(2)
    expect(game2012030221.shots).to eq(8)
    expect(game2012030221.tackles).to eq(44)
    expect(game2012030221.pim).to eq(8)
    expect(game2012030221.power_play_opportunities).to eq(3)
    expect(game2012030221.power_play_goals).to eq(0)
    expect(game2012030221.face_off_win_percentage).to eq(44.8)
    expect(game2012030221.giveaways).to eq(17)
    expect(game2012030221.takeaways).to eq(7)
  end
end