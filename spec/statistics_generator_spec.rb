require_relative 'spec_helper'
require './lib/statistics_generator'


RSpec.describe StatisticsGenerator do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_generator = StatisticsGenerator.from_csv(@locations)
  end

  describe 'initialize' do
    it 'exists' do
      expect(@stat_generator).to be_a(StatisticsGenerator)
    end
  end

  it 'processed team data, retrieves data from teams' do
    expect(@stat_generator.teams).to all(be_a(Team))
  end

  it 'processed team data, retrieves data from games' do
    expect(@stat_generator.games).to all(be_a(Game))
  end

  it 'processed season data, creates hash of season info' do
    expect(@stat_generator.seasons_by_id).to be_a(Hash)
    expect(@stat_generator.seasons_by_id["20122013"][:games]).to all(be_a(Game))
    expect(@stat_generator.seasons_by_id["20122013"][:game_teams]).to all(be_a(GameTeam))
  end

  it 'can parse data into a string of objects' do
    expect(@stat_generator.games).to be_a(Array)
    expect(@stat_generator.games).to all(be_a(Game))
  end

  it 'processed team data, retrieves data from teams' do
    expect(@stat_generator.game_teams).to all(be_a(GameTeam))
  end
end