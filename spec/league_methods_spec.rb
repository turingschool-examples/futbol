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
    expect(@stat_tracker.calc_average_goals_alltime(@stat_tracker.game_teams, 4)).to eq(2.0377358490566038)
  end

  it 'can return team name of team with the best offense' do
    expect(@stat_tracker.best_offense(@stat_tracker.game_teams, @stat_tracker.teams)).to eq("Reign FC")
  end

  it 'can return team name of team with the worst offense' do
    expect(@stat_tracker.worst_offense(@stat_tracker.game_teams, @stat_tracker.teams)).to eq("Utah Royals FC")
  end

end
