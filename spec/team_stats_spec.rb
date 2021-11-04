require 'csv'
require 'simplecov'
require './lib/team_stats'

SimpleCov.start

RSpec.describe TeamStats do
  before :each do
    @team_path = './data/sample_game_teams.csv'
    @team_info_path = './data/teams.csv'

    @team_stats = TeamStats.new(@team_path)
  end

  it 'exists' do

    expect(@team_stats).to be_instance_of(TeamStats)
  end

  it 'team_info' do

    expect(@team_stats.team_info).to be_instance_of(Hash)
  end
end

#team_id, franchise_id, team_name, abbreviation, and link

#season wins, season losses
#goals in a single game
#win percentage against the given team
