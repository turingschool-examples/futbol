require './lib/stat_tracker.rb'
require './spec/spec_helper.rb'
require 'pry'

RSpec.describe StatTracker do
  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'
  locations = {games: game_path, teams: team_path, game_teams: game_teams_path}

  subject {StatTracker.new(locations)}

  it "returns instance of StatTracker" do
    expect(StatTracker.from_csv(locations)).to be_a(StatTracker)
  end

  it "can access seperate csv files " do
    expect(subject.game_path).to eq(game_path)
    expect(subject.team_path).to eq(team_path)
    expect(subject.game_teams_path).to eq(game_teams_path)
  end

end
