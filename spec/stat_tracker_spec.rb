require 'spec_helper'

RSpec.describe StatTracker do

  before(:each) do
    # full data 
    # game_path = './data/games.csv'
    # team_path = './data/teams.csv'
    # game_teams_path = './data/game_teams.csv'
    
    # subset data
    game_path = './data/games_subset.csv'
    team_path = './data/teams_subset.csv'
    game_team_path = './data/game_teams_subset.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_team_path
    }
    
    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
    expect(@stat_tracker.game_list).to be_a(GameList)
    expect(@stat_tracker.team_list).to be_a(TeamList)
    expect(@stat_tracker.game_team_list).to be_a(GameTeamList)
  end

  it 'can find highest score' do
    expect(@stat_tracker.highest_total_score).to eq(5)
  end

  it 'can find the lowest score' do
    expect(@stat_tracker.lowest_total_score).to eq(1)
  end

  xit "can calculate percentage of home wins" do
    game_list = GameList.new('./data/games_subset.csv', 'stat_tracker')

    expect(@stat_tracker.percentage_home_wins).to eq(0.70)
  end

  xit "can calculate percentage of visitor wins" do
    game_list = GameList.new('./data/games_subset.csv', 'stat_tracker')

    expect(@stat_tracker.percentage_visitor_wins).to eq(0.25)
  end

  xit "can calculate percentage of ties" do
    game_list = GameList.new('./data/games_subset.csv', 'stat_tracker')

    expect(@stat_tracker.percentage_ties).to eq(0.05)
  end
  
end
