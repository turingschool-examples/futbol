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

    # why did this finally work?? suddenly needed to make locations an instance throughout...
    # think about it, cause the answer is there, then ask Cyd if no one can deduce
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
    @game_list.create_games(@locations[:games]) # makes it more dynamic, but needed more scope than the '.csv/path.whateveres'
    
    expect(@game_list.games).to all(be_an_instance_of(Game))
  end

  # changed to 8 after subset update, need to update stat_tracker test
  it 'can find highest total score' do
    expect(@game_list.highest_total_score).to eq(8)
  end

  it 'can find the lowest total score' do
    expect(@game_list.lowest_total_score).to eq(1)
  end

  # Meg needs to write this test?
  xit 'can calculate the count of games by season' do
    expect().to eq()
  end

  # Steve needs to write his damn methods, the three below specifically
  # Also, the eq() quantities need to be updated due to the subset update
  xit 'can calculate percentage of home wins' do
    require 'pry'; binding.pry
    expect(@game_list.percentage_home_wins).to eq()
  end

  xit 'can calculate percentage of visitor wins' do
    expect(@game_list.percentage_visitor_wins).to eq()
  end

  xit 'can calculate percentage of ties' do
    expect(@game_list.percentage_ties).to eq()
  end

end