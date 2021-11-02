require 'csv'
require 'simplecov'
require './lib/game_stats'

SimpleCov.start

RSpec.describe GameStats do
  before :each do
    @game_path = './data/sample_games.csv'
    # @team_path = './data/teams.csv'
    # @game_team_path = './data/game_teams.csv'
    @game_stats = GameStats.new(@game_path)
  end
  it 'exists' do

    expect(@game_stats).to be_an_instance_of(GameStats)
  end

  it "#highest_total_score" do

    expect(@game_stats.highest_total_score).to eq(5)
  end

  it "#percentage_home_wins" do

    expect(@game_stats.percentage_home_wins).to eq(62.50)
  end
end
