require './spec/spec_helper'

RSpec.describe StatTracker do

  before(:each) do
    games_file = './data/games_dummy.csv'
    teams_file = './data/teams.csv'
    game_teams_file = './data/game_teams_dummy.csv'

    locations = {
      games: games_file,
      teams: teams_file,
      game_teams: game_teams_file
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_a StatTracker
  end

  it 'initializes data from a CSV file' do
    expect(@stat_tracker.games.first).to be_a Game
    expect(@stat_tracker.teams.first).to be_a Team
    expect(@stat_tracker.game_teams.first).to be_a GameTeam
  end

  it "#highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 11
  end

  it "#lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq 0
  end

  it "#count_of_teams" do
    expect(@stat_tracker.count_of_teams).to eq 32
  end

  it "#best_offense" do
    expect(@stat_tracker.best_offense).to eq "Reign FC"
  end

  it "#worst_offense" do
    expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
  end

  it "#most_tackles" do
    expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end



end
