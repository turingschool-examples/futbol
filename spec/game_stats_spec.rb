require 'spec_helper'
require 'csv'

describe GameStats do
  let(:game_path) { './data/games.csv' }
  let(:team_path) { './data/teams.csv' }
  let(:game_teams_path) { './data/game_teams.csv' }
  let(:locations) do {
          games: game_path,
          teams: team_path,
          game_teams: game_teams_path
          }
  end
  let(:stat_tracker) { StatTracker.from_csv(locations) }
  
  let(:game_stats) { GameStats.new(locations) }

  it 'can import game data' do
  
  expect(stat_tracker.game_stats.games[0].id).to eq(2012030221)
  end

  it 'can list wins_losses' do

  expect(stat_tracker.game_stats.total_games).to eq(7441)
  expect(stat_tracker.game_stats.percentage_home_wins).to eq(0.44)
  expect(stat_tracker.game_stats.percentage_visitor_wins).to eq(0.36)
  expect(stat_tracker.game_stats.percentage_ties).to eq(0.2)
  end

  it 'can return highest score' do
    
    expect(stat_tracker.game_stats.highest_total_score).to eq(11)
  end

  it 'can return lowest score' do

    expect(stat_tracker.game_stats.lowest_total_score).to eq(0)
  end

  it 'returns a count of games by season' do

    expect(stat_tracker.game_stats.count_of_games_by_season).to eq({"20122013"=>806, 
                                                    "20162017"=>1317, 
                                                    "20142015"=>1319, 
                                                    "20152016"=>1321, 
                                                    "20132014"=>1323, 
                                                    "20172018"=>1355})
  end

  it 'returns average goals per game' do

    expect(stat_tracker.game_stats.average_goals_per_game).to eq(4.22)
  end

  it 'returns total goals by season' do

    expect(stat_tracker.game_stats.goals_per_season).to eq({"20122013"=>3322, 
                                            "20162017"=>5565, 
                                            "20142015"=>5461, 
                                            "20152016"=>5499, 
                                            "20132014"=>5547, 
                                            "20172018"=>6019})
  end

  it 'returns total games by season' do

    expect(stat_tracker.game_stats.games_per_season).to eq({"20122013"=>806, 
                                            "20162017"=>1317, 
                                            "20142015"=>1319, 
                                            "20152016"=>1321, 
                                            "20132014"=>1323, 
                                            "20172018"=>1355})
  end

  it 'returns average games per season' do

    expect(stat_tracker.game_stats.average_goals_by_season).to eq({ "20122013" => 4.12,
                                                    "20132014" => 4.19,
                                                    "20142015" => 4.14,
                                                    "20152016" => 4.16,
                                                    "20162017" => 4.23,
                                                    "20172018" => 4.44,})
  end

  it 'returns percent home wins' do
    
    expect(stat_tracker.game_stats.percentage_home_wins).to eq(0.44)
  end

  it 'returns percent visitor wins' do 

    expect(stat_tracker.game_stats.percentage_visitor_wins).to eq(0.36)
  end

  it 'returns percent ties' do

    expect(stat_tracker.game_stats.percentage_ties).to eq(0.20)
  end
end