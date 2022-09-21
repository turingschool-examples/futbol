require 'spec_helper'

RSpec.describe FutbolData do
  before (:all) do
    fixture_game_path = 'spec/fixture/games_fixture.csv'
    fixture_team_path = 'spec/fixture/teams_fixture.csv'
    fixture_game_teams_path = 'spec/fixture/game_teams_fixture.csv'

    locations = {
      games: fixture_game_path,
      teams: fixture_team_path,
      game_teams: fixture_game_teams_path
    }
    
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    @futbol = FutbolData.new(@teams_data, @game_teams_data)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@futbol).to be_an_instance_of(FutbolData)
    end

    it 'has teams data' do
      expect(@futbol.teams_data).to eq(@teams_data)
    end

    it 'has game teams data' do
      expect(@futbol.game_teams_data).to eq(@game_teams_data)
    end
  end
end