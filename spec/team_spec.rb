# require '../futbol/lib/stat_tracker'
# require './lib/team'
# require 'csv'
# require 'pry'

# RSpec.describe Teams do
#   before(:each) do
#     team_data = {
#       team_id: 1,
#       franchiseid: 23,
#       teamname: "Atlanta United",
#       abbreviation: "ATL",
#       stadium: "Mercedes-Benz Stadium",
#       link: "/api/v1/teams/1"
#     }
#     @teams = Teams.new(team_data)
#   end

#   it 'exists' do
#     expect(@teams).to be_an_instance_of(Teams)
#   end

#   it 'has a team_id' do
#     expect(@teams.team_id).to eq(1)
#   end

# end