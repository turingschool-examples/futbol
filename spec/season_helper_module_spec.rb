require 'spec_helper'

RSpec.describe Seasonable do
  mock_games_data = './data/mock_games.csv' 
  team_data = './data/teams.csv' 
  mock_game_teams_data = './data/mock_game_teams.csv' 

  let!(:mock_locations) {{games: mock_games_data, teams: team_data, game_teams: mock_game_teams_data}}

  let!(:season_1213) { SeasonStatistics.from_csv(mock_locations, "20122013") }
  let!(:season_1516) { SeasonStatistics.from_csv(mock_locations, "20152016") }

  it '#games_by_season' do
    expect(season_1213.games_by_season("20122013")).to include("2012030132")
    expect(season_1516.games_by_season("20152016")).to include("2015020975")
  end

  it '#coaches_by_season' do
    expect(season_1213.coaches_by_season("20122013")).to include(:"Dan Bylsma")
    expect(season_1516.coaches_by_season("20152016")).to include(:"Paul Maurice")
  end

  it '#coach_records' do
    expect(season_1213.coach_records("20122013")).to include(:"John Tortorella"=>{:wins=>0, :total_games=>0})
    expect(season_1516.coach_records("20152016")).to include(:"Lindy Ruff"=>{:wins=>0, :total_games=>0})
  end

  # it '#process_coach_records' do
  #   expect(season_1213.games_by_season("20122013")).to include("2012030132")
  #   expect(season_1516.games_by_season("20152016")).to include("2015020975")
  # end

  # it '#process_coach_record' do
  #   expect(season_1213.games_by_season("20122013")).to include("2012030132")
  #   expect(season_1516.games_by_season("20152016")).to include("2015020975")
  # end

  # it '#winning_record' do
  #   expect(season_1213.games_by_season("20122013")).to include("2012030132")
  #   expect(season_1516.games_by_season("20152016")).to include("2015020975")
  # end

  it '#accuracy_records' do
    expect(season_1213.accuracy_records("20122013")).to include(:"2"=>{:shots=>0, :goals=>0})
    expect(season_1516.accuracy_records("20152016")).to include(:"25"=>{:shots=>0, :goals=>0})
  end

  # it '#populate_accuracy_records' do
  #   expect(season_1213.games_by_season).to include("2012030132")
  #   expect(season_1516.games_by_season).to include("2015020975")
  # end

  # it '#process_accuracy_records' do
  #   expect(season_1213.games_by_season).to include("2012030132")
  #   expect(season_1516.games_by_season).to include("2015020975")
  # end

  # it '#most_accurate' do
  # expect(season_1213.games_by_season).to include("2012030132")
  #   expect(season_1516.games_by_season).to include("2015020975")
  # end

  # it '#least_accurate' do
  #   expect(season_1213.games_by_season).to include("2012030132")
  #   expect(season_1516.games_by_season).to include("2015020975")
  # end

  it '#tackle_records' do
    expect(season_1213.tackle_records("20122013")).to include(:"3"=>0)
    expect(season_1516.tackle_records("20152016")).to include(:"25"=>0)
  end

  # it '#populate_tackle_records' do
  #   expect(season_1213.games_by_season).to include(:"3"=>0)
  #   expect(season_1516.games_by_season).to include(:"25"=>0)
  # end

  # it '#process_tackle_record' do
  #   expect(season_1213.games_by_season).to include("2012030132")
  #   expect(season_1516.games_by_season).to include("2015020975")
  # end

  # it '#best_tackling_team' do
  #   expect(season_1213.games_by_season).to include("2012030132")
  #   expect(season_1516.games_by_season).to include("2015020975")
  # end

  # it '#worst_tackling_team' do
  #   expect(season_1213.games_by_season).to include("2012030132")
  #   expect(season_1516.games_by_season).to include("2015020975")
  # end

  it '#teams_by_season' do
    expect(season_1213.teams_by_season("20122013")).to include(:"5")
    expect(season_1516.teams_by_season("20152016")).to include(:"25")
  end

  it '#find_team_name_by_id_number' do
    expect(season_1213.find_team_name_by_id(:"3")).to eq("Houston Dynamo")
    expect(season_1516.find_team_name_by_id(:"25")).to include("Chicago Red Stars")
  end
end

