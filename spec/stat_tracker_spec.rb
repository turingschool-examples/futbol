require './spec_helper'
require './lib/stat_tracker'


RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/sample_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/sample_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end


  it 'can calculate the average goals per game' do 
    expect(@stat_tracker.average_goals_per_game).to eq(4.3)
  end

  it 'will calculate the average goals per game by season' do 
    # expect(@stat_tracker.average_goals_by_season).to be_a(Hash)
    expect(@stat_tracker.average_goals_by_season["20122013"]).to eq(4.5)
  end

  it 'counts the number of games by season' do
    expect(@stat_tracker.count_of_games_by_season).to eq({

      "20122013"=>10, 
      "20132014"=>10, 
      "20142015"=>10
    })  
  end

  it "calculates home win %" do
    expect(@stat_tracker.percentage_home_wins).to eq  0.48
  end

  it 'calculates visitor win %' do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.32
  end

  it 'calculates percent of ties' do
    expect(@stat_tracker.percentage_ties).to eq 0.19
  end

  it 'will calculate the highest scoring visitor' do 
    expect(@stat_tracker.highest_scoring_visitor).to eq("Sporting Kansas City")
  end

  it 'will calculate the lowest scoring visitor' do 
    expect(@stat_tracker.lowest_scoring_visitor).to eq("Columbus Crew SC")
  end

  it 'will calculate the highest scoring home team' do 
    expect(@stat_tracker.highest_scoring_home_team).to eq("Seattle Sounders FC")
  end
  it 'will calculate the lowest scoring home team' do 
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Minnesota United FC")
  end

  it "can calculate the season with the highest win percentage for a team" do
    expect(@stat_tracker.best_season("4")).to eq("20142015")
  end

  it "can calculate the season with the lowest win percentage for a team" do
    expect(@stat_tracker.worst_season("4")).to eq("20132014")
  end

  it 'will find a teams favorite opponenet' do 
    expect(@stat_tracker.favorite_opponent("7")).to eq("Sporting Kansas City")
  end
end
