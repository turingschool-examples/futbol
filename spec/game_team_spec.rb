RSpec.describe GameTeam do
  let(:game_team_data) {
    { game_id: "2012030221",
      team_id: "3",
      HoA: "away",
      result: "LOSS",
      head_coach: "John Tortorella",
      goals: 2,
      shots: 8,
      tackles: 44,
      pim: 8,
      powerPlayOpportunities: 3,
      powerPlayGoals: 0,
      faceOffWinPercentage: 44.8,
      giveaways: 17,
      takeaways: 7
    }}

  let(:game_team) { GameTeam.new(game_team_data) }

  describe '#initialize' do
    it 'can initialize' do
      expect(game_team).to be_a(GameTeam)
      expect(game_team.game_id).to eq("2012030221")
      expect(game_team.team_id).to eq("3")
      expect(game_team.HoA).to eq("away")
      expect(game_team.result).to eq("LOSS")
      expect(game_team.head_coach).to eq("John Tortorella")
      expect(game_team.goals).to eq(2)
      expect(game_team.shots).to eq(8)
      expect(game_team.tackles).to eq(44)
      expect(game_team.pim).to eq(8)
      expect(game_team.powerPlayOpportunities).to eq(3)
      expect(game_team.powerPlayGoals).to eq(0)
      expect(game_team.faceOffWinPercentage).to eq(44.8)
      expect(game_team.giveaways).to eq(17)
      expect(game_team.takeaways).to eq(7)
    end
  end

end
