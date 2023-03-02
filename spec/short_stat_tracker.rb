require 'spec_helper'
require 'csv'

describe StatTracker do
  let(:game_path) { './data/short_games.csv' }
  let(:team_path) { './data/teams.csv' }
  let(:game_teams_path) { './data/short_game_teams.csv' }
  let(:locations) do {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
end
let(:stat_tracker) { StatTracker.from_csv(locations) }

  it 'can import shortened game data' do
    expect(stat_tracker.game_stats.games).to be_instance_of(Array)
    expect(stat_tracker.game_stats.games.length).to eq(14)
  end
  it 'can import shortened game_team data' do
    expect(stat_tracker.league_stats.game_teams).to be_instance_of(Array)
    expect(stat_tracker.league_stats.game_teams.length).to eq(28)
  end
  it 'can import team data' do
    expect(stat_tracker.season_stats.teams).to be_instance_of(Array)
    expect(stat_tracker.season_stats.teams.length).to eq(32)
  end
  it '#highest_total_score' do
    expect(stat_tracker.game_stats.highest_total_score).to eq(5)
  end
  it '#lowest_total_score' do
    expect(stat_tracker.game_stats.lowest_total_score).to eq(1)
  end
  it '#percentage_home_wins' do
    expect(stat_tracker.game_stats.percentage_home_wins).to eq(0.5)
  end
  it '#percentage_visitor_wins' do
    expect(stat_tracker.game_stats.percentage_visitor_wins).to eq(0.5)
  end

  it '#percentage_ties' do
    expect(stat_tracker.game_stats.percentage_ties).to eq(0)
  end

  it '#count_of_games_by_season' do
    expect(stat_tracker.game_stats.count_of_games_by_season).to eq({"20122013" => 10,
                                                                    "20132014" => 3,
                                                                    "20162017" => 1,})
  end

  it '#average_goals_per_game' do
    expect(stat_tracker.game_stats.average_goals_per_game).to eq(4.07)
  end
  it '#average_goals_by_season' do
    expect(stat_tracker.game_stats.average_goals_by_season).to eq({"20122013"=>3.9, 
                                                                   "20132014"=>5.0, 
                                                                   "20162017"=>3.0})
  end

  it '#count_of_teams' do
    expect(stat_tracker.league_stats.count_of_teams).to eq(32)
  end
  it '#best_offense' do
    expect(stat_tracker.league_stats.best_offense).to eq("FC Dallas")
  end
  it '#worst_offense' do
    expect(stat_tracker.league_stats.worst_offense).to eq("Sporting Kansas City")
  end
  it '#highest_scoring_visitor' do
    expect(stat_tracker.league_stats.highest_scoring_visitor).to eq("FC Dallas")
  end
  it '#highest_scoring_home_team' do
    expect(stat_tracker.league_stats.highest_scoring_home_team).to eq("FC Dallas")
  end
  it '#lowest_scoring_visitor' do
    # expect(stat_tracker.league_stats.lowest_scoring_away).to eq("Sporting Kansas City")
  end
  it '#lowest_scoring_home_team' do
    # expect(stat_tracker.league_stats.lowest_scoring_home).to eq("Sporting Kansas City")
  end
end