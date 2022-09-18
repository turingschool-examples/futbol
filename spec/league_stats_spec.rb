require 'csv'
require 'rspec'
require './lib/league_stats.rb'

RSpec.describe LeagueStats do 
  before(:each) do 
    LeagueStats.from_csv_paths({game_csv:'./data/games.csv', gameteam_csv:'./data/game_teams.csv', team_csv:'./data/teams.csv'})
  end

  it '#count_of_teams'do
      expect(LeagueStats.count_of_teams).to eq 32
  end

  it '#best_offense' do
    expect(LeagueStats.best_offense).to eq "Reign FC"
  end

  it '#worst_offense' do
    expect(LeagueStats.worst_offense).to eq "Utah Royals FC"
  end

  it '#highest_scoring_visitor' do
    expect(LeagueStats.highest_scoring_visitor).to eq "FC Dallas"
  end

  it '#highest_scoring_home_team' do
    expect(LeagueStats.highest_scoring_home_team).to eq "Reign FC"
  end

  it '#lowest_scoring_visitor' do
    expect(LeagueStats.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  end

end