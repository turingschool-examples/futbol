require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'
require './lib/game'

RSpec.describe StatTracker do
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
    # should we instantiate an object?
    @game = Game.new(@stat_tracker.game_data)
  end

  # it "exists" do
  #   expect(@stat_tracker).to be_an_instance_of StatTracker
  # end

  it "#highest_total_score" do
    expect(@game.highest_total_score).to eq 11
  end

  it "#lowest_total_score" do
    expect(@game.lowest_total_score).to eq 0
  end

  it "#percentage_home_wins" do
    expect(@game.percentage_home_wins).to eq 0.44
  end

  it "#percentage_visitor_wins" do
    expect(@game.percentage_visitor_wins).to eq 0.36
  end

  it "#percentage_ties" do
    expect(@game.percentage_ties).to eq 0.20
  end

  xit "#count_of_games_by_season" do
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    expect(@game.count_of_games_by_season).to eq expected
  end

  xit "#average_goals_per_game" do
    expect(@game.average_goals_per_game).to eq 4.22
  end

  xit "#average_goals_by_season" do
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    expect(@game.average_goals_by_season).to eq expected
  end
end