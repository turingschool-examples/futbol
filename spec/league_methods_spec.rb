require_relative 'spec_helper'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:each) do
    @game_path = './data/games_test.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @filenames = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@filenames)
  end

  it 'can return count of teams' do
    expect(@stat_tracker.count_of_teams(@stat_tracker.teams)).to eq(32)
  end

  it 'can #calc_average_goals_alltime' do
    expect(@stat_tracker.calc_avg_goals_alltime(@stat_tracker.game_teams, 4)).to eq(2.0377358490566038)
  end

  it 'can return team name of team with the best offense' do
    expect(@stat_tracker.best_offense(@stat_tracker.game_teams, @stat_tracker.teams)).to eq("Reign FC")
  end

  it 'can return team name of team with the worst offense' do
    expect(@stat_tracker.worst_offense(@stat_tracker.game_teams, @stat_tracker.teams)).to eq("Utah Royals FC")
  end

  it 'can return the average all-time goals when playing away or home' do
    expect(@stat_tracker.calc_avg_goals_alltime(@stat_tracker.game_teams, 6, "away")).to eq(2.2450592885375493)
    expect(@stat_tracker.calc_avg_goals_alltime(@stat_tracker.game_teams, 6, "home")).to eq(2.280155642023346)
  end

  it 'can return team name of team with highest all-time average score when playing away' do
    expect(@stat_tracker.highest_scoring_visitor(@stat_tracker.game_teams, @stat_tracker.teams)).to eq("FC Dallas")
  end

  it 'can return team name of team with highest all-time average score when playing at home' do
    expect(@stat_tracker.highest_scoring_home_team(@stat_tracker.game_teams, @stat_tracker.teams)).to eq("Reign FC")
  end

  it 'can return team name of team with lowest all-time average score when playing away' do
    expect(@stat_tracker.lowest_scoring_visitor(@stat_tracker.game_teams, @stat_tracker.teams)).to eq("San Jose Earthquakes")
  end

  it 'can return team name of team with lowest all-time average score when playing at home' do
    expect(@stat_tracker.lowest_scoring_home_team(@stat_tracker.game_teams, @stat_tracker.teams)).to eq("Utah Royals FC")
  end

end
