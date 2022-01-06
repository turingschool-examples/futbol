require './lib/games_teams'
require 'pry'

RSpec.describe GamesTeams do
    it 'exists and has attributes' do
      attributes = {
      game_id: 2012030221,
      team_id: 3,
      hoa: "away",
      result: "LOSS",
      settled_in: "OT",
      head_coach: "John Tortorella",
      goals: 2,
      shots: 8,
      tackles: 44,
      pim: 8,
      powerPlayOpportunities: 3,
      power_play_goals: 0,
      faceoff_win_percentage: 44.8,
      giveaways: 17,
      takeaways: 7}

    games_teams = GamesTeams.new(attributes)
      expect(games_teams).to be_a(GamesTeams)
      expect(games_teams.game_id).to eq(2012030221)
      expect(games_teams.team_id).to eq(3)
      expect(games_teams.hoa).to eq("away")
      expect(games_teams.result).to eq("LOSS")
      expect(games_teams.settled_in).to eq("OT")
      expect(games_teams.head_coach).to eq("John Tortorella")
      expect(games_teams.goals).to eq(2)
      expect(games_teams.shots).to eq(8)
      expect(games_teams.tackles).to eq(44)
      expect(games_teams.pim).to eq(8)
      expect(games_teams.powerPlayOpportunities).to eq(3)
      expect(games_teams.power_play_goals).to eq(0)
      expect(games_teams.faceoff_win_percentage).to eq(44.8)
      expect(games_teams.giveaways).to eq(17)
      expect(games_teams.takeaways).to eq(7)
    end

end
