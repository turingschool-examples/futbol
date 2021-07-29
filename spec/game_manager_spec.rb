require 'spec_helper'

RSpec.describe GameManager do
  before(:each) do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @game_manager = GameManager.new(locations)
  end

  it "exists" do
    expect(@game_manager).to be_a(GameManager)
  end

  it "is an array" do
    expect(@game_manager.games).to be_an(Array)
  end

  it "adds team scores together for total score" do
    expect(@game_manager.total_game_score).to eq([5, 6, 4, 1, 5, 7, 3, 5, 6, 4, 4, 3, 4, 4, 6, 5, 5, 5, 5])
  end

  it "finds the higest total score" do
    expect(@game_manager.highest_total_score).to eq(7)
  end

  it "finds the lowest total score" do
    expect(@game_manager.lowest_total_score).to eq(1)
  end

  it 'counts total games' do
    expect(@game_manager.total_games).to eq(19)
  end

  it 'has home wins count' do
    expect(@game_manager.home_wins_count).to eq(12)
  end

  it 'has home win percents' do
    expect(@game_manager.percent_home_wins).to eq(63.2)
  end

  it 'has visitor wins count' do
    expect(@game_manager.visitor_wins_count).to eq(2)
  end

  it 'has visitor win percents' do
    expect(@game_manager.percent_visitor_wins).to eq(10.5)
  end

  it 'has a tie count' do
    expect(@game_manager.tie_count).to eq(5)
  end

  it 'has tie percent' do
    expect(@game_manager.percent_ties).to eq(26.3)

  end
  # it "is an array of season numbers" do
  #   result = ["20122013", "20152016", "20132014", "20142015", "20172018", "20162017"]
  #   expect(@game_manager.array_of_seasons).to eq(result)
  # end
end
