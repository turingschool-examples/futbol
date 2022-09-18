require'csv'
require'rspec'
require'./lib/season_stats.rb'

RSpec.describe SeasonStats do
  before(:each) do
    SeasonStats.from_csv_paths({game_csv:'./data/games.csv', gameteam_csv:'./data/game_teams.csv', team_csv:'./data/teams.csv'})
  end

  it "#winningest_coach" do
    expect(SeasonStats.winningest_coach("20132014")).to eq "Claude Julien"
    expect(SeasonStats.winningest_coach("20142015")).to eq "Alain Vigneault"
  end

  it "#worst_coach" do
    expect(SeasonStats.worst_coach("20132014")).to eq "Peter Laviolette"
    expect(SeasonStats.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
  end

  it "#most_accurate_team" do
    expect(SeasonStats.most_accurate_team("20132014")).to eq "Real Salt Lake"
    expect(SeasonStats.most_accurate_team("20142015")).to eq "Toronto FC"
  end

  it "#least_accurate_team" do
    expect(SeasonStats.least_accurate_team("20132014")).to eq "New York City FC"
    expect(SeasonStats.least_accurate_team("20142015")).to eq "Columbus Crew SC"
  end

  it "#most_tackles" do
    expect(SeasonStats.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(SeasonStats.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end

  it "#fewest_tackles" do
    expect(SeasonStats.fewest_tackles("20132014")).to eq "Atlanta United"
    expect(SeasonStats.fewest_tackles("20142015")).to eq "Orlando City SC"
  end

end