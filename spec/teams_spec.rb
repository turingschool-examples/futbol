require 'spec_helper'

RSpec.describe Teams do
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
    expect(teams = Teams.new("Rabbits","20122013")).to be_a Teams
  end

  it "has instance variables" do
    teams = Teams.new("Rabbits","20122013")
    expect(teams.team_name).to eq("Rabbits")
    expect(teams.team_id).to eq("20122013")
  end

  it "has a create games class method" do
    expect(Teams.create_teams(team_path)).to be_an Array
    Teams.create_teams(team_path).each do |team|
      expect(team).to be_a Teams
    end
  end
end
