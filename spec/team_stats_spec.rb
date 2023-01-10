require 'csv'
require 'spec_helper.rb'

RSpec.describe TeamStats do
  let(:game_path) { './data/games_fixture.csv' }
  let(:team_path) { './data/teams_fixture.csv' }
  let(:game_teams_path) { './data/game_teams_fixture.csv' }
  let(:locations) do 
    {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  end
  let(:stat_tracker) { StatTracker.from_csv(locations) }
  let(:teamstats) {TeamStats.new(locations)}
  describe "Team Statistics" do
    it "#team_info" do
      expect(teamstats.team_info("6")).to eq({
        "team_id"=> "6", 
        "franchise_id"=> "6", 
        "team_name"=> "FC Dallas", 
        "abbreviation"=> "DAL", 
        "link"=> "/api/v1/teams/6"
      })
    end

  it "#best_season" do 
    game_path = './data/games.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv' 
    locations = 
      {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    
    stat_tracker = StatTracker.from_csv(locations) 
    teamstats = TeamStats.new(locations)
    expect(teamstats.best_season("6")).to eq("20122013")
    expect(teamstats.best_season("3")).to eq("20142014").or(eq("20162017"))
  end

  it "#worst_season" do 
    game_path = './data/games.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv' 
    locations = 
      {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

    stat_tracker = StatTracker.from_csv(locations) 
    teamstats = TeamStats.new(locations)
    expect(teamstats.worst_season("6")).to eq("20132014")
    expect(teamstats.worst_season("3")).to eq("20122013").or(eq("20172018")).or(eq("20152016"))
  end

  it "#average_win_percentage" do
  game_path = './data/games.csv'
  team_path = './data/teams_fixture.csv'
  game_teams_path = './data/game_teams_fixture.csv' 
  locations = 
    {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  
    stat_tracker = StatTracker.from_csv(locations) 
    teamstats = TeamStats.new(locations)
  expect(teamstats.average_win_percentage("3")).to eq(0.39)
  expect(teamstats.average_win_percentage("6")).to eq(0.67)
end

  it "#most_goals_scored" do
    expect(teamstats.most_goals_scored("3")).to eq(5)
    expect(teamstats.most_goals_scored("6")).to eq(4)
  end

  it "#fewest_goals_scored" do
    expect(teamstats.fewest_goals_scored("3")).to eq(0)
    expect(teamstats.fewest_goals_scored("6")).to eq(1)
  end

  it "#favorite_opponent" do
    game_path = './data/games.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv' 
    locations = 
      {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    
    stat_tracker = StatTracker.from_csv(locations) 
    teamstats = TeamStats.new(locations)
    expect(teamstats.favorite_opponent("3")).to eq("DC United").or(eq("Real Salt Lake"))
    expect(teamstats.favorite_opponent("6")).to eq("Houston Dynamo").or(eq("DC United")).or(eq("New York City FC"))
  end

  it "#rival" do
    game_path = './data/games.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv' 
    locations = 
      {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    
    stat_tracker = StatTracker.from_csv(locations) 
    teamstats = TeamStats.new(locations)
    expect(teamstats.rival("3")).to eq("FC Dallas").or(eq("Orlando Pride")).or(eq("Los Angeles FC")).or(eq("Seattle Sounders FC"))
    expect(teamstats.rival("6")).to eq("Sporting Kansas City").or(eq("Philadelphia Union")).or(eq("Utah Royals FC"))
  end


  it "#groups the relevant games and gameteams for the circumstance based on the season" do
    game_path = './data/games.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv' 
    locations = 
      {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    
    stat_tracker = StatTracker.from_csv(locations) 
    teamstats = TeamStats.new(locations)
    expect(teamstats.rival("3")).to eq("FC Dallas").or(eq("Orlando Pride")).or(eq("Los Angeles FC")).or(eq("Seattle Sounders FC"))
    expect(teamstats.rival("6")).to eq("Sporting Kansas City").or(eq("Philadelphia Union")).or(eq("Utah Royals FC"))
  end

  end 
end 