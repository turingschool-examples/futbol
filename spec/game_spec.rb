require 'spec_helper'
require 'rspec'
require 'csv'

RSpec.describe Game do
  before(:each) do
   game_path       = './data/games.csv'
   team_path       = './data/teams.csv'
   game_teams_path = './data/game_teams.csv'

   locations = {
     games: game_path,
     teams: team_path,
     game_teams: game_teams_path
   }
   
      tracker = StatTracker.from_csv(locations)
      @game_data = tracker.games
 end

  describe 'Game instance' do
     it 'exists' do
       expect(@game_data.first).to be_a(Game)
     end

     it 'has correct attributes' do
       expect(@game_data.first.game_id).to eq('2012030221')
       expect(@game_data.first.season).to eq('20122013')
       expect(@game_data.first.type).to eq('Postseason')
       expect(@game_data.first.date_time).to eq('5/16/13')
       expect(@game_data.first.away_team_id).to eq('3')
       expect(@game_data.first.home_team_id).to eq('6')
       expect(@game_data.first.away_goals).to eq('2')
       expect(@game_data.first.home_goals).to eq('3')
       expect(@game_data.first.venue).to eq('Toyota Stadium')
       expect(@game_data.first.venue_link).to eq('/api/v1/venues/null')
     end
  end
end

