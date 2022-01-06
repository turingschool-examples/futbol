require './lib/stat_tracker.rb'
require './spec/spec_helper.rb'
require './lib/league_statistics'
require 'pry'

RSpec.describe LeagueStatistics do
  before(:each) do
    game_path = './data/games_samples.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_samples.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

  end

  it 'exists' do
    league = LeagueStatistics.new(@locations)
    expect(league).to be_instance_of(LeagueStatistics)
  end

    xit 'can count the number of teams' do
      league = LeagueStatistics.new(@locations)
    expect(league.count_of_teams).to eq(32)
    end

  end
