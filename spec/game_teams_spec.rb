require './lib/game_teams'

RSpec.describe GameTeams do
  before(:each) do
    @game_teams = GameTeams.new("2012030221", "3", "away", "LOSS", "John Tortorella", "2", "44")
  end

  describe 'initialize' do
    it 'exists' do
    expect(@game_teams).to be_a(GameTeams)
    end
  end
end