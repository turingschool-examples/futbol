require 'spec_helper'

RSpec.describe GameList do

  before(:each) do
    
    # full data: for when we go live
    # game_path = './data/games.csv'
    # game_teams_path = './data/game_teams.csv'
    # team_path = './data/teams.csv'
    
    # subset data: for faster testing purposes
    game_path = './data/games_subset.csv'
    team_path = './data/teams_subset.csv'
    game_team_path = './data/game_teams_subset.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_team_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)

    @game_list = GameList.new(@locations[:games], @stat_tracker)
  end

  it 'can create a new GameList class instance' do
    expect(@game_list).to be_a(GameList)
    expect(@game_list.games).to be_a(Array)
    expect(@game_list.games[0]).to be_a(Game)
  end

  it 'can create instances of Game' do
    @game_list.create_games(@locations[:games])
    
    expect(@game_list.games).to all(be_an_instance_of(Game))
  end

  it 'can find highest total score' do
    expect(@game_list.highest_total_score).to eq(8)
  end

  it 'can find the lowest total score' do
    expect(@game_list.lowest_total_score).to eq(1)
  end

  it 'can calculate percentage of home wins' do
    expect(@game_list.percentage_home_wins).to eq(0.50)
  end
  
  it 'can calculate percentage of visitor wins' do
    expect(@game_list.percentage_visitor_wins).to eq(0.37)
  end
  
  it 'can calculate percentage of ties' do
    expect(@game_list.percentage_ties).to eq(0.14)
  end
  
  it 'can calculate the count of games by season' do
    expect(@game_list.count_of_games_by_season).to eq({"20122013"=>25, "20132014"=>5})
  end

end