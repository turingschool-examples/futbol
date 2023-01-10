require_relative 'spec_helper'

RSpec.describe GameTeams do
  before(:all) do
    game_teams_path = './spec/fixtures/game_teams_fixture.csv'

    locations = {
      # games: game_path,
      # teams: team_path,
      game_teams: game_teams_path
    }
    @game_teams_path = CSV.read(locations[:game_teams], headers: true, skip_blanks: true, header_converters: :symbol)
    @gameteam = GameTeams.new(@game_teams_path)
  end
  describe '#initialize'
  it 'exists' do 
    # game_teams = GameTeams.new(@game_teams_path)
    expect(@gameteam).to be_an_instance_of(GameTeams)
  end
  
  it 'has attributes' do
    expect(@gameteam.game_id).to be_a(Array)
  end
end