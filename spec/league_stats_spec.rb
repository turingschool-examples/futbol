require './lib/stat_tracker'

RSpec.describe LeagueStatistics do 
  before(:all) do
    game_path = './data/dummy_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  it '#count_of_teams' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it '#average_goals' do
    expect(@stat_tracker.average_goals).to eq({"16"=>1.0, "17"=>2.0, "24"=>2.0, "25"=>2.0, "26"=>3.0, "8"=>2.5, "9"=>1.0})
  end
  it '#worst_offense' do
    expect(@stat_tracker.worst_offense). to eq('New England Revolution')
  end

  it '#highest_scoring_visitor' do
    expect(@stat_tracker.highest_scoring_visitor).to eq('FC Cincinnati')
  end

  it '#highest_scoring_home_team' do
    expect(@stat_tracker.highest_scoring_home_team).to eq('New York Red Bulls')
  end

  it '#lowest_scoring_visitor' do
    expect(@stat_tracker.lowest_scoring_visitor).to eq('New England Revolution')
  end

  it '#lowest_scoring_home_team' do
    expect(@stat_tracker.lowest_scoring_home_team).to eq('New York City FC')
  end

  it '#average_goals' do
    expect(@stat_tracker.average_goals).to eq({"16"=>1.0, "17"=>2.0, "24"=>2.0, "25"=>2.0, "26"=>3.0, "8"=>2.5, "9"=>1.0})
  end
end