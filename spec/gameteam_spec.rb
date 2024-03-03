require 'spec_helper'

RSpec.describe GameTeam do
  before(:all) do
    @game_teams = GameTeam.create_from_csv("./data/game_teams_dummy.csv")
  end

  describe '#initialize' do
    before(:each) do
      game_team_data = { game_id: "2014030232",
        team_id: "30",
        hoa: "away",
        result: "LOSS",
        head_coach: "Mike Yeo",
        goals: 1,
        shots: 7,
        tackles: 42
      }
      @game_team1 = GameTeam.new(game_team_data)
    end

    it 'exists' do
      expect(@game_team1).to be_an_instance_of GameTeam
    end

    it 'has attributes that can be read' do
      expect(@game_team1.game_id).to eq "2014030232"
      expect(@game_team1.team_id).to eq "30"
      expect(@game_team1.hoa).to eq "away"
      expect(@game_team1.result).to eq "LOSS"
      expect(@game_team1.head_coach).to eq "Mike Yeo"
      expect(@game_team1.goals).to eq 1
      expect(@game_team1.shots).to eq 7
      expect(@game_team1.tackles).to eq 42
    end
  end

  describe '#methods' do
    it "can create GameTeam objects using the create_from_csv method" do
      test_game = @game_teams.first

      expect(test_game.game_id).to eq("2012030221")
      expect(test_game.team_id).to eq("3")
      expect(test_game.hoa).to eq("away")
      expect(test_game.result).to eq("LOSS")
      expect(test_game.head_coach).to eq('John Tortorella')
      expect(test_game.goals).to eq(2)
      expect(test_game.shots).to eq(8)
      expect(test_game.tackles).to eq(44)
    end

    it 'can take in a season ID and return a hash of team_ids and number of tackles for that season' do
      expected_20122013 = {"3" => 179, "5" => 117, "6" => 246}
      expected_20132014 = {"16" => 48, "26" => 69}

      expect(GameTeam.tackles_per_team("20122013")).to eq expected_20122013
      expect(GameTeam.tackles_per_team("20132014")).to eq expected_20132014
    end

    it 'can return the team with the fewest tackles' do
      tackles_20122013 = {"3" => 179, "5" => 117, "6" => 246}
      tackles_20132014 = {"16" => 48, "26" => 69}

      expect(GameTeam.fewest_tackles(tackles_20122013)).to eq "5"
      expect(GameTeam.fewest_tackles(tackles_20132014)).to eq "16"
    end

    it 'can return the team with the fewest tackles for a given season' do
      expect(GameTeam.fewest_tackles_by_season("20122013")).to eq "5"
      expect(GameTeam.fewest_tackles_by_season("20132014")).to eq "16"
    end
  end

  it "can check for team with the highest average number of goals scored per game across all seasons" do
    expect(GameTeam.best_offense).to eq("Reign FC")
  end

  # it "can check for team with the lowest average number of goals scored per game across all seasons" do
  #   expect(GameTeam.worst_offense).to eq("Utah Royals FC")
  # end
end
