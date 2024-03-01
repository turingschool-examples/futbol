require './spec/spec_helper'

RSpec.describe StatTracker do

  before(:all) do
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

  it '#percentage_home_wins returns correct return value' do
    percentage_home_wins = @stat_tracker.percentage_home_wins
    expect(percentage_home_wins).to be_a Float
    expect(percentage_home_wins).to eq 0.48
  end

  it '#percentage_visitor_wins returns correct return value' do
    percentage_visitor_wins = @stat_tracker.percentage_visitor_wins
    expect(percentage_visitor_wins).to be_a Float
    expect(percentage_visitor_wins).to eq 0.29
  end

  it '#percentage_ties returns correct return value' do
    percentage_ties = @stat_tracker.percentage_ties
    expect(percentage_ties).to be_a Float
    expect(percentage_ties).to eq 0.23
  end

  it '#count_of_games_by_season' do
    games_by_season = @stat_tracker.count_of_games_by_season
    expect(games_by_season).to be_a Hash
    expect(games_by_season.count).to eq 6
  end

  it '#average_goals_by_season' do
    goals_by_season = @stat_tracker.count_of_games_by_season
    expect(goals_by_season).to be_a Hash
    expect(goals_by_season.count).to eq 6
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
