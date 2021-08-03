require 'spec_helper'


RSpec.describe StatTracker do
  before(:each) do

    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  xit "exists" do
    expect(@stat_tracker).to be_a(StatTracker)
  end

  xit 'has a game manager' do
    expect(@stat_tracker.game_manager).to be_a(GameManager)
  end

  xit 'has a team manager' do
    expect(@stat_tracker.team_manager).to be_a(TeamManager)
  end

  xit 'has a game team manager' do
    expect(@stat_tracker.game_team_manager).to be_a(GameTeamManager)
  end

  xit 'has a season manager' do
    expect(@stat_tracker.season_manager).to be_a(SeasonManager)
  end

  xit 'has winningest coach by season' do
    expect(@stat_tracker.winningest_coach('20132014')).to eq("Claude Julien")
  end

  xit 'has worst coach by season' do
    expect(@stat_tracker.worst_coach('20132014')).to eq("Peter Laviolette")
  end

  it 'has most accurate team id' do
    expect(@stat_tracker.most_accurate_team('20132014')).to eq('Real Salt Lake')
  end

  it 'has least accurate team_id' do
    expect(@stat_tracker.least_accurate_team('20132014')).to eq('New York City FC')
  end

  xit 'has team with most tackles' do
    expect(@stat_tracker.most_tackles('20122013')).to eq('FC Dallas')
  end

  xit 'has team with least tackles' do
    expect(@stat_tracker.fewest_tackles('20122013')).to eq('New England Revolution')
  end

  xit "counts number of teams" do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  xit "returns the name of the team with the highest avg goals per game" do
    expect(@stat_tracker.best_offense).to eq("FC Dallas")
  end

  xit "returns the name of the team with the highest avg goals per game" do
    expect(@stat_tracker.best_offense).to eq("FC Dallas")
  end

  xit "returns the name of the team with the lowest avg goals per game" do
    expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
  end

  xit "text" do
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  xit "text" do
    expect(@stat_tracker.highest_scoring_home_team).to eq("FC Dallas")
  end

  xit "text" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("Sporting Kansas City")
  end

  xit "text" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Sporting Kansas City")
  end

  xit "checks highest total score" do
    expect(@stat_tracker.highest_total_score).to eq(5)
  end

  xit "checks lowest total score" do
    expect(@stat_tracker.lowest_total_score).to eq(1)
  end

  xit "checks percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq(60.0)
  end

  xit "checks percentage_visitor_wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq(40.0)
  end

  xit "can check the percentage of ties" do
    expect(@stat_tracker.percentage_ties).to eq(0.0)
  end

  xit 'checks count of games by season' do
    expect(@stat_tracker.count_of_games_by_season).to eq({"20122013"=>10})
  end

  xit 'checks average goals per game' do
    expect(@stat_tracker.average_goals_per_game).to eq(3.7)
  end

  xit 'checks average goals by season' do
    expect(@stat_tracker.average_goals_by_season).to eq({"20122013"=>3.7})
  end

  xit 'gets team info' do
    expect(@stat_tracker.team_info("16")).to eq({:abbreviation=>"NE", :franchise_id=>"11", :link=>"/api/v1/teams/16", :team_id=>"16", :team_name=>"New England Revolution"})
  end

  xit 'gets best season' do
    expect(@stat_tracker.best_season("16")).to eq("20122013")
  end

  xit 'gets worst season' do
    expect(@stat_tracker.worst_season("16")).to eq("20122013")
  end

  xit 'gets average win percentage' do
    expect(@stat_tracker.average_win_percentage("16")).to eq(100.0)
  end

  xit 'gets most goals scored' do
    expect(@stat_tracker.most_goals_scored("16")).to eq(0)
  end

  xit 'gets fewest goals scored' do
    expect(@stat_tracker.fewest_goals_scored("6")).to eq(0)
  end

  xit 'gets favorite opponent' do
    expect(@stat_tracker.favorite_opponent("16")).to eq("LA Galaxy")
  end

  xit 'gets rival' do
    expect(@stat_tracker.rival("16")).to eq("LA Galaxy")
  end

end
