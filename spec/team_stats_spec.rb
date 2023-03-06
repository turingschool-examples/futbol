require_relative './spec_helper'

RSpec.describe TeamStats do
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
  end

  it 'can create team hash' do
    expect(@stat_tracker.team_info("1")["team_id"]).to eq("1")
    expect(@stat_tracker.team_info("1")["franchise_id"]).to eq("23")
    expect(@stat_tracker.team_info("1")["team_name"]).to eq("Atlanta United")
    expect(@stat_tracker.team_info("1")["abbreviation"]).to eq("ATL")
    expect(@stat_tracker.team_info("1")["link"]).to eq("/api/v1/teams/1")
  end

  it '#best_season' do 
    expect(@stat_tracker.best_season("6")).to eq "20132014"
  end

  it "#favorite_opponent" do
    expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
  end

  it "#rival" do
    expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
  end

  it '#biggest_team_blowout' do
    expect(@stat_tracker.biggest_team_blowout("18")).to eq(5)
  end

  it '#worst_loss' do
    expect(@stat_tracker.worst_loss("18")).to eq(4)
  end
end