require 'spec_helper'

RSpec.describe GameTeam do
  before(:all) do
    @game_teams = GameTeam.create_from_csv("./data/game_teams_dummy.csv")
  end

  describe '#initialize' do
    before(:each) do
      game_team_data = { game_id: 2014030232,
        team_id: 30,
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
      expect(@game_team1.game_id).to eq 2014030232
      expect(@game_team1.team_id).to eq 30
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
      new_game_teams = GameTeam.create_from_csv("./data/game_teams_dummy.csv")
      starting_game_team = new_game_teams.first
      expect(starting_game_team.game_id).to eq(2_012_030_221)
      expect(starting_game_team.team_id).to eq(3)
      expect(starting_game_team.hoa).to eq("away")
      expect(starting_game_team.result).to eq("LOSS")
      expect(starting_game_team.head_coach).to eq('John Tortorella')
      expect(starting_game_team.goals).to eq(2)
      expect(starting_game_team.shots).to eq(8)
      expect(starting_game_team.tackles).to eq(44)
    end
  end

  it "can check for team with the highest average number of goals scored per game across all seasons" do
    expect(GameTeam.best_offense).to eq("Reign FC")
  end

  # it "can check for team with the lowest average number of goals scored per game across all seasons" do
  #   expect(GameTeam.worst_offense).to eq("Utah Royals FC")
  # end
end
