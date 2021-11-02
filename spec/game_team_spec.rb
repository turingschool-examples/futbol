require './lib/game_team'
require 'csv'

describe GameTeam do
  before(:each) do
    @rows = CSV.read('./data/game_teams.csv', headers: true)
    @row = @rows[0]

    @game_id = 2012030221
    @team_id = 3
    @h_o_a = 'away'
    @result = 'LOSS'
    @settled_in = 'OT'
    @head_coach = 'John Tortorella'

    # ,goals,shots,tackles,pim,powerPlayOpportunities,powerPlayGoals,faceOffWinPercentage,giveaways,takeaways
    @game_team = GameTeam.new(@row)
  end
  describe 'initialize' do
    it 'exists' do
      expect(@game_team).to be_a(GameTeam)
    end
    it 'has attributes' do
      expect(@game_team.game_id).to eq(2012030221)
      expect(@game_team.team_id).to eq(3)
      expect(@game_team.h_o_a).to eq('away')
      expect(@game_team.result).to eq('LOSS')
      expect(@game_team.settled_in).to eq('OT')
      expect(@game_team.head_coach).to eq('John Tortorella')
    end
  end
end
