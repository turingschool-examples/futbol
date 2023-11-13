require 'spec_helper'

RSpec.describe StatTracker do

  before(:each) do
    
    # full data: for when we go live
    # game_path = './data/games.csv'
    # game_teams_path = './data/game_teams.csv'
    # team_path = './data/teams.csv'
    
    # subset data: for faster testing purposes
    game_path = './data/games_subset.csv'
    team_path = './data/teams_subset.csv'
    game_team_path = './data/game_teams_subset.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_team_path
    }
    
    @stat_tracker = StatTracker.from_csv(locations)
    @game_list = GameList.new(game_path, @stat_tracker)
    @team_list = TeamList.new(team_path, @stat_tracker)
    @game_team_list = GameTeamList.new(game_team_path, @stat_tracker)
  end

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
    expect(@stat_tracker.game_list).to be_a(GameList)
    expect(@stat_tracker.team_list).to be_a(TeamList)
    expect(@stat_tracker.game_team_list).to be_a(GameTeamList)
  end

  it 'can find highest total score' do
    expect(@stat_tracker.highest_total_score).to eq(8)
  end
  
  it 'can find the lowest total score' do
    expect(@stat_tracker.lowest_total_score).to eq(1)
  end

  it 'game_list: can calculate percentage of home wins' do
    expect(@stat_tracker.percentage_home_wins).to eq(0.50)
  end

  it 'game_list: can calculate percentage of visitor wins' do
    expect(@stat_tracker.percentage_visitor_wins).to eq(0.37)
  end

  it 'game_list: can calculate percentage of ties' do
    expect(@stat_tracker.percentage_ties).to eq(0.14)
  end

  it 'game_list: can calculate count of games by season' do
    expect(@stat_tracker.count_of_games_by_season).to eq({"20122013"=>25, "20132014"=>5})
  end

  # xit 'team_list: can return the highest scoring visitor team' do
  #   expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  # end
  
  # xit 'stat_tracker: can return the highest scoring home team' do
  #   expect(@stat_tracker.highest_scoring_home_team).to eq("New York City FC")
  # end
  
end