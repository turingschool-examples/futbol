require './spec_helper'

RSpec.describe 'StatTracker' do
  let(:game_path) {'./data/games.csv'}
  let(:team_path) {'./data/teams.csv'}
  let(:game_teams_path) {'./data/game_teams.csv'}
  let(:baby_data) {'./data/baby_data.csv'}
  let(:locations) {{
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }}
  let(:stat_tracker) {StatTracker.new(locations)}

  it "exists" do
    expect(stat_tracker).to be_a StatTracker
  end

  it "can filter_by_header" do
    expected = ["WIN", "LOSS", "LOSS", "LOSS", "WIN"]
    expect(stat_tracker.filter_by_header(baby_data, :result)).to eq(expected)
    expected = ["home", "away", "home", "away", "home"]
    expect(stat_tracker.filter_by_header(baby_data, :hoa)).to eq(expected)
  end

end
