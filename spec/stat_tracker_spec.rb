require './spec/spec_helper'

RSpec.describe StatTracker do

  before(:all) do
    games_file = './data/games_dummy.csv'
    teams_file = './data/teams.csv'
    game_teams_file = './data/game_teams_dummy.csv'

    locations = {
      games: games_file,
      teams: teams_file,
      game_teams: game_teams_file
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_a StatTracker
  end

  it 'initializes data from a CSV file' do
    expect(@stat_tracker.games.first).to be_a Game
    expect(@stat_tracker.teams.first).to be_a Team
    expect(@stat_tracker.game_teams.first).to be_a GameTeam
  end

  it '#percentage_home_wins returns correct return value' do
    expect(@stat_tracker.percentage_home_wins).to be_a Float
    expect(@stat_tracker.percentage_home_wins).to eq 0.48
  end

  it '#percentage_visitor_wins returns correct return value' do
    expect(@stat_tracker.percentage_visitor_wins).to be_a Float
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.29
  end

  it '#percentage_ties returns correct return value' do
    expect(@stat_tracker.percentage_ties).to be_a Float
    expect(@stat_tracker.percentage_ties).to eq 0.23
  end

  it '#count_of_games_by_season' do
    games_by_season = @stat_tracker.count_of_games_by_season
    expect(games_by_season).to be_a Hash
    expect(games_by_season.count).to eq 6
  end

end