require './lib/game'

RSpec.describe Game do
  it 'exists and can take a hash' do
    game = Game.new({
      game_id:      '1',
      season:       'k',
      away_team_id: '3',
      home_team_id: '2',
      away_goals:   '4',
      home_goals:   '1'
    })

    expect(game).to be_a(Game)
    expect(game.game_id).to eq('1')
    expect(game.season).to eq('k')
    expect(game.away_team_id).to eq('3')
    expect(game.home_team_id).to eq('2')
    expect(game.away_goals).to eq('4')
    expect(game.home_goals).to eq('1')
  end

  it 'can determine if a team played in that game' do
    game = Game.new({
      game_id:      '1',
      season:       'k',
      away_team_id: '3',
      home_team_id: '2',
      away_goals:   '4',
      home_goals:   '1'
    })

    expect(game.played?('2')).to eq(true)
    expect(game.played?('10')).to eq(false)
    expect(game.played?('3')).to eq(true)
  end

  it 'can determine if the team won' do
    game = Game.new({
      game_id:      '1',
      season:       'k',
      away_team_id: '3',
      home_team_id: '2',
      away_goals:   '4',
      home_goals:   '1'
    })

    expect(game.won?('3')).to eq(true)
    expect(game.won?('2')).to eq(false)
    expect(game.won?('10')).to eq(false)
  end

  it 'can determine whether they are home or away' do
    game = Game.new({
      game_id:      '1',
      season:       'k',
      away_team_id: '3',
      home_team_id: '2',
      away_goals:   '4',
      home_goals:   '1'
    })

    expect(game.home?('2')).to eq(true)
    expect(game.home?('3')).to eq(false)
    expect(game.home?('10')).to eq(false)
    expect(game.away?('2')).to eq(false)
    expect(game.away?('3')).to eq(true)
    expect(game.away?('10')).to eq(false)
  end
end
