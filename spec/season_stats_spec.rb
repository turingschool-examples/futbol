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
    @test_game_teams1 = @stat_tracker.game_teams[0]
    @test_game_teams2 = @stat_tracker.game_teams[1]
    @test_game1 = @stat_tracker.games[0]
    @test_game2 = @stat_tracker.games[1]
    @test_team1 = @stat_tracker.teams[0]
    @test_team2 = @stat_tracker.teams[1]

    @test_games = @stat_tracker.games[0..9]
    @test_game_teams = @stat_tracker.game_teams[0..9]
  end

  it 'exists' do
    expect(@stat_tracker.season_rspec_test).to be true
  end

  it 'can determine the best coach' do
    @stat_tracker.games = @stat_tracker.games[0..24]
    @stat_tracker.game_teams = @stat_tracker.game_teams[0..24]
    
    expect(@stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
  end

  it 'can determine the worst coach' do
    @stat_tracker.games = @stat_tracker.games[0..24]
    @stat_tracker.game_teams = @stat_tracker.game_teams[0..24]
  
    expect(@stat_tracker.worst_coach("20122013")).to eq("Joel Quenneville")
  end

  it 'can determine the most accurate team' do
    @stat_tracker.games = @stat_tracker.games[0..24]
    @stat_tracker.game_teams = @stat_tracker.game_teams[0..24]
  
    expect(@stat_tracker.most_accurate_team("20122013")).to eq("FC Dallas")
  end

  it 'can determine the least accurate team' do
    @stat_tracker.games = @stat_tracker.games[0..24]
    @stat_tracker.game_teams = @stat_tracker.game_teams[0..24]
  
    expect(@stat_tracker.least_accurate_team("20122013")).to eq("Sporting Kansas City")
  end
end