# require '../futbol/lib/stat_tracker'
# require 'csv'
# require './lib/games'
# require 'pry'

# RSpec.describe Games do
#   before(:each) do
#     games_data = {
#       game_id: 2012030221,
#       season: 20122013,
#       type: "Postseason",
#       date_time: "5/16/13",
#       away_team_id: 3,
#       home_team_id: 6,
#       away_goals: 2,
#       home_goals: 3,
#       venue: "Toyota Stadium",
#       venue_link: "/api/v1/venues/null"
#     }

#     @games = Games.new(games_data)
#   end 

#   it 'exists' do
#     expect(@games).to be_an_instance_of(Games)
#   end


#   it 'stores data in an hash' do
#     expect(@games.away_goals).to eq(2)
#   end

# end