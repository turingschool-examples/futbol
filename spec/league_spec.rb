require './lib/league'

RSpec.describe do League
  it 'exists' do
    game_path = './data/game_teams_stub.csv'
    locations = {games: game_path}
    league = League.new(locations[:games])
    expect(league).to be_a(League)
  end

  it 'can count teams' do
    game_path = './data/game_teams_stub.csv'
    locations = {games: game_path}
    league = League.new(locations[:games])
    expect(league.count_of_teams).to eq(5)
  end

  it 'can tell best offense' do
    game_path = './data/game_teams_stub.csv'
    locations = {games: game_path}
    league = League.new(locations[:games])
  end

  # it '' do
  # end
  #
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end
  # it '' do
  # end

end
