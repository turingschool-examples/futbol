require_relative './spec_helper'

describe SeasonStats do
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

    @test_games = @stat_tracker.games[0..9]
    @test_games_larger = @stat_tracker.games[0..100]
    @test_game_teams = @stat_tracker.game_teams[0..9]
    @test_game_teams_larger = @stat_tracker.game_teams[0..200]
  end

  it 'exists' do
    expect(@stat_tracker.season_rspec_test).to be true
  end

  it 'can determine the best coach' do
    @stat_tracker.game_teams = @test_game_teams_larger

    expect(@stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
    expect(@stat_tracker.winningest_coach("20152016")).to eq("Mike Sullivan")
  end

  it 'can determine the worst coach' do
    @stat_tracker.game_teams = @test_game_teams_larger

    expect(@stat_tracker.worst_coach("20122013")).to eq("John Tortorella")
    expect(@stat_tracker.worst_coach("20152016")).to eq("Alain Vigneault")
  end

  it 'can determine the most accurate team' do
    @stat_tracker.game_teams = @test_game_teams_larger

    expect(@stat_tracker.most_accurate_team("20122013")).to eq("New York City FC")
    expect(@stat_tracker.most_accurate_team("20152016")).to eq("Sporting Kansas City")
  end

  it 'can determine the least accurate team' do
    @stat_tracker.game_teams = @test_game_teams_larger

    expect(@stat_tracker.least_accurate_team("20122013")).to eq("Houston Dynamo")
    expect(@stat_tracker.least_accurate_team("20152016")).to eq("Chicago Fire")
  end

  it 'determines the team with the most tackles' do 
    @stat_tracker.game_teams = @test_game_teams_larger

    expect(@stat_tracker.most_tackles("20132014")).to eq("Philadelphia Union")
  end
  
  it 'determines the team with the fewest tackles' do 
    @stat_tracker.game_teams = @test_game_teams_larger

    expect(@stat_tracker.fewest_tackles("20132014")).to eq("New England Revolution")
  end
end