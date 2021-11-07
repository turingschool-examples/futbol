require 'csv'
require 'simplecov'
require './lib/team_stats'
# require './lib/game_team'

SimpleCov.start

RSpec.describe TeamStats do
  before :each do
    @team_info_path = './data/teams.csv'
    @rows = CSV.read(@team_info_path, headers: true)
    @row = @rows[1]
    @team_stats = TeamStats.new(@row)

    # @team_path = './data/game_teams.csv'
    # @rows = CSV.read(@team_path, headers: true)
    # @row = @rows[1]
    # @game_team = GameTeam.new(@row)


    @team_stats = TeamStats.new(@team_info_path)
    # @game_team = GameTeam.new(@team_path)
  end

  it 'exists' do

    expect(@team_stats).to be_instance_of(TeamStats)
  end

  # it 'team_info' do
  #
  #   expect(@team_stats.team_data).to be_instance_of(Hash)
  # end
end
#team_id, franchise_id, team_name, abbreviation, and link

#season wins, season losses
#goals in a single game
#win percentage against the given team
