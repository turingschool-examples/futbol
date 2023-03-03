require_relative './spec_helper'

describe GameStats do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    # @test_game_teams1 = @stat_tracker.game_teams[0]
    # @test_game_teams2 = @stat_tracker.game_teams[1]
    # @test_game1 = @stat_tracker.games[0]
    # @test_game2 = @stat_tracker.games[1]
    # @test_team1 = @stat_tracker.teams[0]
    # @test_team2 = @stat_tracker.teams[1]

    @test_games = @stat_tracker.games[0..9]
    @test_games_larger = @stat_tracker.games[0..50]
    #@test_game_teams = @stat_tracker.game_teams[0..9]
    #@test_game_teams_larger = @stat_tracker.game_teams[0..50]
  end

  it 'exists' do
    expect(@stat_tracker.game_rspec_test).to be true
  end

  it 'can determine highest score' do
    @stat_tracker.games = @test_games

    expect(@stat_tracker.highest_total_score).to eq(5)
  end

  it 'can determine lowest score' do
    @stat_tracker.games = @test_games

    expect(@stat_tracker.lowest_total_score).to eq(1)
  end

  it 'can determine percentage of home wins' do
    @stat_tracker.games = @test_games

    expect(@stat_tracker.percentage_home_wins).to eq(0.60)
  end

  it 'can determine percentage of visitor wins' do
    @stat_tracker.games = @test_games
    expect(@stat_tracker.percentage_visitor_wins).to eq(0.40)
  end

  it 'can determine percentage of ties' do
    @stat_tracker.games = @test_games_larger

    expect(@stat_tracker.percentage_ties).to eq(0.02)
  end

  it 'can count games by season' do
    @stat_tracker.games = @test_games
    expected = ({'20122013' => 10})
    expect(@stat_tracker.count_of_games_by_season).to be_a Hash
    expect(@stat_tracker.count_of_games_by_season.keys[0]).to be_a String
    expect(@stat_tracker.count_of_games_by_season.values[0]).to be_a Integer
    expect(@stat_tracker.count_of_games_by_season).to eq(expected)
  end

  it 'can determine the average goals per game' do
    @stat_tracker.games = @test_games

    expect(@stat_tracker.average_goals_per_game).to be_a Float
    expect(@stat_tracker.average_goals_per_game).to eq(3.7)
  end

  it 'can determine average goals by season' do
    @stat_tracker.games = @test_games
    expected = {"20122013" => 3.7}

    expect(@stat_tracker.average_goals_by_season).to be_a Hash
    expect(@stat_tracker.average_goals_by_season.keys[0]).to be_a String
    expect(@stat_tracker.average_goals_by_season.values[0]).to be_a Float
    expect(@stat_tracker.average_goals_by_season).to eq(expected)
  end
end
