require './spec_helper'
require './lib/league_statistics'
require 'csv'
require 'pry'

RSpec.describe(LeagueStatistics) do
  before :each do
    @game_teams_data = CSV.read "data/fixture_data_league_statistics/dummy_game_teams.csv", headers: true, header_converters: :symbol
    @teams_data = CSV.read "data/teams.csv", headers: true, header_converters: :symbol
    @data_sets = [@game_teams_data, @teams_data]

    @league_statistics = LeagueStatistics.new(@data_sets)
  end
  it 'exists' do
    expect(@league_statistics).to be_an_instance_of(LeagueStatistics)
  end
  it 'has a CSV data set' do
    expect(@league_statistics.data_set[0]).to be_a(CSV::Table)
    expect(@league_statistics.data_set[0]).to eq(@game_teams_data)
  end
  it 'has a count of teams' do
    expect(@league_statistics.count_of_teams).to eq(11)
  end
  it 'can return a hash of rounded average goals by team id' do
    expect(@league_statistics.total_team_goal_averages).to be_a(Hash)
    expect(@league_statistics.total_team_goal_averages[19]).to eq(3)
  end
end
