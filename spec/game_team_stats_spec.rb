require 'csv'
require 'simplecov'
require './lib/game_team_stats'

SimpleCov.start

RSpec.describe GameTeamStats do
  before :each do
    @game_teams_path = './data/game_teams.csv'
    @rows = CSV.read(@game_teams_path, headers: true)
    @row = @rows[1]
    @game_team_stats = GameTeamStats.new(@row)
  end
  it 'exists' do

    expect(@game_team_stats).to be_an_instance_of(GameTeamStats)
  end
end