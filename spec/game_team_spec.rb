require_relative 'spec_helper'

RSpec.describe GameTeam do
  describe 'initialization' do
    it 'exists and has attributes' do
      game_team = GameTeam.new({
        "game_id"                => "2012030221",
        "team_id"                => "3",
        "HoA"                    => "away",
        "result"                 => "LOSS",
        "head_coach"             => "John Tortorella",
        "goals"                  => 2,
        "shots"                  => 8,
        "tackles"                => 44
        # "powerPlayOpportunities" => 3,
        # "powerPlayGoals"         => 0,
        # "faceOffWinPercentage"   => 44.8,
        # "giveaways"              => 17,
        # "takeaways"              => 7
      })

      expect(game_team).to be_a(GameTeam)
      expect(game_team.team_id).to eq("3")
    end
  end
end
