require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'
require './lib/league'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @league = League.new(@stat_tracker.game_data, @stat_tracker.team_data, @stat_tracker.game_team_data)
  end

  it "exists" do
    expect(@league).to be_an_instance_of League
  end

  it "#count_of_teams" do
    expect(@league.count_of_teams).to eq 32
  end

  it "team_total_goals" do
    expect(@league.team_total_goals).to be_a(Hash)
    expect(@league.team_total_goals["3"]).to eq(1129)
  end

  it "#team_total_games" do
    expect(@league.team_total_games).to be_a(Hash)
    expect(@league.team_total_games["3"]).to eq(531)
  end

  it "#best_offense" do
    expect(@league.best_offense).to eq "Reign FC"
  end

  it "#worst_offense" do
    expect(@league.worst_offense).to eq "Utah Royals FC"
  end

  it "#highest_scoring_visitor" do
    expect(@league.highest_scoring_visitor).to eq "FC Dallas"
  end

  it "#highest_scoring_home_team" do
    expect(@league.highest_scoring_home_team).to eq "Reign FC"
  end

  it "#lowest_scoring_visitor" do
    expect(@league.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  end

  it "#lowest_scoring_home_team" do
    expect(@league.lowest_scoring_home_team).to eq "Utah Royals FC"
  end

  it '#visitor goals' do
    expect(@league.visitor_goals["3"]).to eq(572)
  end

  it '#total_games' do
    expect(@league.total_games["3"]).to eq(531)
  end

  it '#ave_visitor_goals' do
    expect(@league.ave_visitor_goals["3"]).to eq(1.0772128060263653)
  end

  it '#highest_ave_visitor_goals' do
    expect(@league.highest_ave_visitor_goals).to eq(["6", 1.1137254901960785])
  end

  it '#lowest_ave_visitor_goals' do
    expect(@league.lowest_ave_visitor_goals).to eq(["27", 0.9230769230769231])
  end

  it '#home_goals' do
    expect(@league.home_goals["6"]).to eq(586)
  end

  it '#ave_home_goals' do
    expect(@league.ave_home_goals["6"]).to eq(1.1490196078431372)
  end

  it '#highest_ave_home_goals' do
    expect(@league.highest_ave_home_goals).to eq(["54", 1.2941176470588236])
  end
end