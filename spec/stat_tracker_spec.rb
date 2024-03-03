require_relative 'spec_helper'

RSpec.describe StatTracker do

  before(:all) do
    games_file = './data/games_dummy.csv'
    teams_file = './data/teams.csv'
    game_teams_file = './data/game_teams.csv'

    locations = {
      games: games_file,
      teams: teams_file,
      game_teams: game_teams_file
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  xit 'exists' do
    expect(@stat_tracker).to be_a StatTracker
  end

  xit 'initializes data from a CSV file' do
    expect(@stat_tracker.games.first).to eq Game
    expect(@stat_tracker.teams.first).to eq Team
    expect(@stat_tracker.game_teams.first).to eq GameTeam
  end

  xit 'has the team by id' do
    expect(@stat_tracker.find_team_name_by_id(6)).to eq "FC Dallas"
  end

  xit '#percentage_home_wins returns correct return value' do
    percentage_home_wins = @stat_tracker.percentage_home_wins
    expect(percentage_home_wins).to be_a Float
    expect(percentage_home_wins).to eq 0.48
  end

  xit '#percentage_visitor_wins returns correct return value' do
    percentage_visitor_wins = @stat_tracker.percentage_visitor_wins
    expect(percentage_visitor_wins).to be_a Float
    expect(percentage_visitor_wins).to eq 0.29
  end

  xit '#percentage_ties returns correct return value' do
    percentage_ties = @stat_tracker.percentage_ties
    expect(percentage_ties).to be_a Float
    expect(percentage_ties).to eq 0.23
  end

  xit '#count_of_games_by_season' do
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

  xit '#average_goals_per_game' do
    goals_per_game_avg = @stat_tracker.average_goals_per_game
    expect(goals_per_game_avg).to be_an Float
    expect(goals_per_game_avg).to eq(4.32)
  end

  it '#highest_scoring_home_team' do
    highest_home_team = @stat_tracker.highest_scoring_home_team
    expect(highest_home_team).to eq("Reign FC")
  end

  it '#lowest_scoring_home_team' do
    lowest_home_team = @stat_tracker.lowest_scoring_home_team
    expect(lowest_home_team).to eq("Utah Royals FC")
  end
end