require './lib/game_team_list.rb'

RSpec.describe GameTeamList do
  it 'can correctly create new Game class instance' do
    game_teams = GameTeamList.new('./data/game_teams.csv', nil)

    expect(game_teams.game_teams.length).to eq(14882)

    game2012030221 = game_teams.game_teams.find { |game| game.game_id == 2012030221}

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
    expect(game2012030221.powerplayopportunities).to eq(3)
    expect(game2012030221.powerplaygoals).to eq(0)
    expect(game2012030221.faceoffwinpercentage).to eq(44.8)
    expect(game2012030221.giveaways).to eq(17)
    expect(game2012030221.takeaways).to eq(7)

    game2016020251 = game_teams.game_teams.find { |game| game.game_id == 2016020251 && game.team_id == 25}

    expect(game2016020251.game_id).to eq(2016020251)
    expect(game2016020251.team_id).to eq(25)
    expect(game2016020251.hoa).to eq("home")
    expect(game2016020251.result).to eq("WIN")
    expect(game2016020251.settled_in).to eq("REG")
    expect(game2016020251.head_coach).to eq("Lindy Ruff")
    expect(game2016020251.goals).to eq(3)
    expect(game2016020251.shots).to eq(5)
    expect(game2016020251.tackles).to eq(7)
    expect(game2016020251.pim).to eq(4)
    expect(game2016020251.powerplayopportunities).to eq(7)
    expect(game2016020251.powerplaygoals).to eq(2)
    expect(game2016020251.faceoffwinpercentage).to eq(51.2)
    expect(game2016020251.giveaways).to eq(8)
    expect(game2016020251.takeaways).to eq(5)

    #2016020251,25,home,WIN,REG,Lindy Ruff,3,5,7,4,7,2,51.2,8,5
  end
end