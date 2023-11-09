require 'spec_helper'

RSpec.describe GameTeams do
  before :each do
    game_path = './data/games_subset.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_subset.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    expect(game_teams = GameTeams.new("2012030221","20122013","home","LOSS","Tom",6,2,3)).to be_a GameTeams
  end

  it "has instance variables" do
    game_teams = GameTeams.new("2012030221","20122013","home","LOSS","Tom",6,2,3)
    expect(game_teams.game_id).to eq("2012030221")
    expect(game_teams.team_id).to eq("20122013")
    expect(game_teams.hoa).to eq("home")
    expect(game_teams.result).to eq("LOSS")
    expect(game_teams.head_coach).to eq("Tom")
    expect(game_teams.goals).to eq(6)
    expect(game_teams.shots).to eq(2)
    expect(game_teams.tackles).to eq(3)
  end

  it "has a create games class method" do
    expect(GameTeams.create_game_teams(game_teams_path)).to be_an Array
    GameTeams.create_game_teams(game_teams_path).each do |game_team|
      expect(game_team).to be_a GameTeams
    end
  end
end
