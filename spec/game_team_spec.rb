require 'csv'
require './lib/game_team'

describe GameTeam do
  before(:each) do
    game_teams_path = './data/game_teams_tester.csv'

    locations = {
      game_teams: game_teams_path
    }

    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
      @game_team = GameTeam.new(row)
    end
  end

  it 'exists' do
    expect(@game_team).to be_instance_of(GameTeam)
  end

end
