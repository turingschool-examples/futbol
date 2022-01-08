require './lib/stat_tracker'
require './lib/games_collection'
require 'pry'


RSpec.describe StatTracker do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'exists' do
    stat_tracker = StatTracker.new(@locations)

    expect(stat_tracker).to be_a(StatTracker)
  end

  it 'from CSV create new StatTracker' do
    stat_tracker = StatTracker.from_csv(@locations)
    expect(stat_tracker).to be_a(StatTracker)
    expect(stat_tracker.locations).to eq(@locations)
  end

  it '#count_of_teams can count total number of teams' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it '#best_offense can find the team with highest average number of goals scored' do
    expect(@stat_tracker.best_offense).to eq("Reign FC")
  end

  it '#worst_offense can find the team with lowest average number of goals scored' do
    expect(@stat_tracker.worst_offense).to eq("Utah Royals FC")
  end

  it '#highest_score_visitor can find the team with highest average score per game' do
    expect(@stat_tracker.highest_score_visitor).to eq("")
  end


end
