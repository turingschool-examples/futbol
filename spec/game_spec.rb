require 'spec_helper'

RSpec.describe Game do

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
    @game_list = GameList.new(locations[:games], @stat_tracker)
    # this uses stat_tracker and game_list to create all the instances of games
    @new_game = @game_list.create_games(locations[:games])
  end
  
  it 'exists' do
    expect(@new_game).to all(be_an_instance_of(Game))
  end

  it 'calculates the total score of the first row' do
    expect(@new_game.first.total_score).to eq(5)
  end

end