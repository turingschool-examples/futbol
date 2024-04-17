require 'spec_helper.rb'

RSpec.describe Game do
  before(:each) do
    @game_path = './data/games_fixture.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_fixture.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it "#count_of_teams" do
    expect(@stat_tracker.count_of_teams).to eq 32
  end

  it "#total_points" do
    expect(@stat_tracker.total_points("3")).to eq 8
    expect(@stat_tracker.total_points("6")).to eq 24
    expect(@stat_tracker.total_points("5")).to eq 2
    expect(@stat_tracker.total_points("17")).to eq 1
    expect(@stat_tracker.total_points("16")).to eq 2
  end

  it "#total_games" do
    expect(@stat_tracker.total_games("3")).to eq 5
    expect(@stat_tracker.total_games("6")).to eq 9
    expect(@stat_tracker.total_games("5")).to eq 4
    expect(@stat_tracker.total_games("17")).to eq 1
    expect(@stat_tracker.total_games("16")).to eq 1
  end

  xit "#best_offense" do
  require 'pry'; binding.pry
    expect(@stat_tracker.best_offense).to eq "Reign FC"
  end

  # it "#worst_offense" do
  #   expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
  # end

  # it "#highest_scoring_visitor" do
  #   expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
  # end

  # it "#highest_scoring_home_team" do
  #   expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
  # end

  # it "#lowest_scoring_visitor" do
  #   expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  # end

  # it "#lowest_scoring_home_team" do
  #   expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
  # end
end
