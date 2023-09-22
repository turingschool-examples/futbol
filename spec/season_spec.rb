require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'
require './lib/season'

RSpec.describe Season do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @season = Season.new(@stat_tracker.game_team_data, @stat_tracker.game_data, @stat_tracker.team_data)  
  end

  it "exists" do
    expect(@season).to be_an_instance_of Season
  end

  it "#coach_totals" do
    expect(@season.coach_totals("20132014")).to be_a Hash
    expect(@season.coach_totals("20132014")["Joel Quenneville"]).to eq(101)
  end

  it "#coach_wins" do
    expect(@season.coach_wins("20132014")).to be_a Hash
    expect(@season.coach_wins("20132014")["Joel Quenneville"]).to eq(47)
  end
  #These two tests pass: They take awhile to run so be patient when uncommenting.  
  it "#winningest_coach" do
    expect(@season.winningest_coach("20132014")).to eq "Claude Julien"
    expect(@season.winningest_coach("20142015")).to eq "Alain Vigneault"
  end
  #These two tests pass: They take awhile to run so be patient when uncommenting.
  it "#worst_coach" do
    expect(@season.worst_coach("20132014")).to eq "Peter Laviolette"
    expect(@season.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
  end

  it '#counts team goals' do
    expect(@season.goals_accurate_team("20122013")).to be_a(Hash)
  end

  it 'counts team shots' do
    expect(@season.shots_accurate_team("20122013")).to be_a(Hash)
  end

  it "#most_accurate_team" do
    expect(@season.most_accurate_team("20132014")).to eq "Real Salt Lake"
    expect(@season.most_accurate_team("20142015")).to eq "Toronto FC"
  end

  it "#least_accurate_team" do
    expect(@season.least_accurate_team("20132014")).to eq "New York City FC"
    expect(@season.least_accurate_team("20142015")).to eq "Columbus Crew SC"
  end

  it "#most_tackles" do
    expect(@season.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(@season.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end

  it "#tackles_game_id" do
    expect(@season.tackles_game_id("20132014")[0]).to eq("2013030161")
  end

  it "#tackles_season_id" do
    expected = {
      :game_id=>"2013030161", 
      :team_id=>"16", 
      :hoa=>"away", 
      :result=>"WIN", 
      :head_coach=>"Joel Quenneville", 
      :goals=>"3", 
      :shots=>"10", 
      :tackles=>"27"
    }
    
    expect(@season.tackles_season_id("20132014")[0]).to eq expected
  end

  it "#fewest_tackles" do
    expect(@season.fewest_tackles("20132014")).to eq "Atlanta United"
    expect(@season.fewest_tackles("20142015")).to eq "Orlando City SC"
  end
end
