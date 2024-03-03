require 'spec_helper'

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
    expect(@stat_tracker.games.first).to be_an_instance_of Game
    expect(@stat_tracker.teams.first).to be_an_instance_of Team
    expect(@stat_tracker.game_teams.first).to be_an_instance_of GameTeam
  end

  it "#highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 9
  end

  it "#lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq 1
  end

  it "#count_of_teams" do
    expect(@stat_tracker.count_of_teams).to eq 32
  end

  it 'has the team by id' do
    expect(@stat_tracker.find_team_name_by_id(6)).to eq "FC Dallas"
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
    goals_by_season = @stat_tracker.average_goals_by_season
    expect(goals_by_season).to be_a Hash
    expect(goals_by_season.count).to eq 6
  end

  it '#fewest_tackles' do
    expect(@stat_tracker.fewest_tackles("20122013")).to eq "Sporting Kansas City"
    expect(@stat_tracker.fewest_tackles("20132014")).to eq "New England Revolution"
  end

  it '#average_goals_per_game' do
    goals_per_game_avg = @stat_tracker.average_goals_per_game
    expect(goals_per_game_avg).to be_an Float
    expect(goals_per_game_avg).to eq(4.32)
  end

  it '#highest_scoring_home_team' do
    highest_home_team = @stat_tracker.highest_scoring_home_team
    expect(highest_home_team).to eq("FC Dallas")
  end

  it '#lowest_scoring_home_team' do
    lowest_home_team = @stat_tracker.lowest_scoring_home_team
    expect(lowest_home_team).to eq("Sporting Kansas City")
  end

  # it "#best_offense" do
  #   expect(@stat_tracker.best_offense).to eq "Reign FC"
  # end

  # it "#worst_offense" do
  #   expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
  # end
end
